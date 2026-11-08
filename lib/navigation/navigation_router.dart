import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../di/di.dart';
import '../features/auth/presentation/cubit/authentication_cubit.dart';
import '../features/auth/presentation/pages/date_of_birth/date_of_birth_page.dart';
import '../features/auth/presentation/pages/name/name_page.dart';
import '../features/auth/presentation/pages/onboarding/onboarding_page.dart';
import '../features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart';
import '../features/auth/presentation/pages/phone_number/phone_number_page.dart';
import '../features/auth/presentation/pages/verify_otp/verify_otp_page.dart';
import '../features/auth/presentation/pages/welcome/welcome_page.dart';
import '../features/product/presentation/pages/product_detail/product_detail_page.dart';
import 'authentication_router_notifier.dart';
import 'index_page.dart';
import 'index_tab.dart';
import 'navigation_key_provider.dart';

@lazySingleton
class NavigationRouter {
  NavigationRouter(this._keyProvider, this._authCubit);

  final INavigationKeyProvider _keyProvider;
  final AuthenticationCubit _authCubit;

  // The sign-up / log-in steps; every other route needs a session.
  static const publicRoutes = {
    OnboardingPage.routePath,
    PhoneNumberPage.routePath,
    VerifyOtpPage.routePath,
    NamePage.routePath,
    DateOfBirthPage.routePath,
  };

  late final _authNotifier = AuthenticationRouterNotifier(_authCubit.stream);

  late final GoRouter router = GoRouter(
    navigatorKey: _keyProvider.navigatorKey,
    refreshListenable: _authNotifier,
    initialLocation: IndexPage.routePath,
    redirect: (_, state) =>
        redirectFor(_authCubit.state, state.matchedLocation),
    routes: [..._authRoutes, _indexRoute],
  );

  static String? redirectFor(AuthenticationState auth, String location) {
    final isPublic = publicRoutes.contains(location);
    return switch (auth) {
      AuthenticationUnknown() => null,
      AuthenticationUnauthenticated() =>
        isPublic ? null : OnboardingPage.routePath,
      Authenticated(isNewMember: true) =>
        location == WelcomePage.routePath ? null : WelcomePage.routePath,
      Authenticated() =>
        isPublic || location == WelcomePage.routePath
            ? IndexPage.routePath
            : null,
    };
  }

  List<GoRoute> get _authRoutes => [
    GoRoute(
      path: OnboardingPage.routePath,
      builder: (_, _) => const OnboardingPage(),
    ),
    GoRoute(
      path: PhoneNumberPage.routePath,
      builder: (_, state) => BlocProvider(
        create: (_) => inject<PhoneNumberCubit>()
          ..start(
            PhoneNumberPage.flowFromQuery(
              state.uri.queryParameters[PhoneNumberPage.flowParam],
            ),
          ),
        child: const PhoneNumberPage(),
      ),
    ),
    _routeWithArgs<VerifyOtpArgs>(
      VerifyOtpPage.routePath,
      (args) => VerifyOtpPage(args: args),
    ),
    _routeWithArgs<NameArgs>(
      NamePage.routePath,
      (args) => NamePage(args: args),
    ),
    _routeWithArgs<DateOfBirthArgs>(
      DateOfBirthPage.routePath,
      (args) => DateOfBirthPage(args: args),
    ),
    GoRoute(
      path: WelcomePage.routePath,
      builder: (_, _) => const WelcomePage(),
    ),
  ];

  GoRoute get _indexRoute => GoRoute(
    path: IndexPage.routePath,
    builder: (_, state) => IndexPage(
      tab: IndexTab.fromQuery(state.uri.queryParameters[IndexTab.queryKey]),
    ),
    routes: [
      GoRoute(
        path: ProductDetailPage.routePath,
        builder: (_, state) => ProductDetailPage(
          productId: state.pathParameters[ProductDetailPage.idParam]!,
        ),
      ),
    ],
  );

  // A step opened without its arguments (deep link, restored route) restarts
  // at Onboarding instead of crashing.
  static GoRoute _routeWithArgs<T>(String path, Widget Function(T) build) =>
      GoRoute(
        path: path,
        redirect: (_, state) =>
            state.extra is T ? null : OnboardingPage.routePath,
        builder: (_, state) => build(state.extra! as T),
      );

  @disposeMethod
  void dispose() {
    router.dispose();
    _authNotifier.dispose();
  }
}
