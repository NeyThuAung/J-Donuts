import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../di/di.dart';
import '../features/auth/presentation/cubit/authentication_cubit.dart';
import '../features/auth/presentation/pages/date_of_birth/cubit/date_of_birth_cubit.dart';
import '../features/auth/presentation/pages/date_of_birth/date_of_birth_page.dart';
import '../features/auth/presentation/pages/name/cubit/name_cubit.dart';
import '../features/auth/presentation/pages/name/name_page.dart';
import '../features/auth/presentation/pages/onboarding/onboarding_page.dart';
import '../features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart';
import '../features/auth/presentation/pages/phone_number/phone_number_page.dart';
import '../features/auth/presentation/pages/verify_otp/cubit/verify_otp_cubit.dart';
import '../features/auth/presentation/pages/verify_otp/verify_otp_page.dart';
import '../features/auth/presentation/pages/welcome/welcome_page.dart';
import '../features/product/domain/entity/product_entity.dart';
import '../features/product/presentation/pages/product_detail/cubit/product_detail_cubit.dart';
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
      pageBuilder: (_, state) => _page(state, const OnboardingPage()),
    ),
    GoRoute(
      path: PhoneNumberPage.routePath,
      pageBuilder: (_, state) => _page(
        state,
        BlocProvider(
          create: (_) => inject<PhoneNumberCubit>()
            ..start(
              PhoneNumberPage.flowFromQuery(
                state.uri.queryParameters[PhoneNumberPage.flowParam],
              ),
            ),
          child: const PhoneNumberPage(),
        ),
      ),
    ),
    _routeWithArgs<VerifyOtpArgs>(
      VerifyOtpPage.routePath,
      (args) => BlocProvider(
        create: (_) =>
            inject<VerifyOtpCubit>()..start(phone: args.phone, flow: args.flow),
        child: VerifyOtpPage(phone: args.phone),
      ),
    ),
    _routeWithArgs<NameArgs>(
      NamePage.routePath,
      (args) => BlocProvider(
        create: (_) => inject<NameCubit>(),
        child: NamePage(phone: args.phone),
      ),
    ),
    _routeWithArgs<DateOfBirthArgs>(
      DateOfBirthPage.routePath,
      (args) => BlocProvider(
        create: (_) => inject<DateOfBirthCubit>()
          ..start(
            phone: args.phone,
            firstName: args.firstName,
            lastName: args.lastName,
          ),
        child: const DateOfBirthPage(),
      ),
    ),
    GoRoute(
      path: WelcomePage.routePath,
      pageBuilder: (_, state) => _page(state, const WelcomePage()),
    ),
  ];

  GoRoute get _indexRoute => GoRoute(
    path: IndexPage.routePath,
    pageBuilder: (_, state) => _page(
      state,
      IndexPage(
        tab: IndexTab.fromQuery(state.uri.queryParameters[IndexTab.queryKey]),
      ),
    ),
    routes: [
      GoRoute(
        path: ProductDetailPage.routePath,
        pageBuilder: (_, state) {
          final productId = state.pathParameters[ProductDetailPage.idParam]!;
          // A deep link or restored route has no preview and no Hero.
          final preview = switch (state.extra) {
            final ProductEntity product when product.id == productId => product,
            _ => null,
          };
          final from = state.uri.queryParameters[ProductDetailPage.fromParam];
          return _page(
            state,
            BlocProvider(
              create: (_) =>
                  inject<ProductDetailCubit>()
                    ..start(productId, preview: preview),
              child: ProductDetailPage(
                productId: productId,
                heroFrom: preview == null ? null : from,
              ),
            ),
          );
        },
      ),
    ],
  );

  // Pages are built here, not by go_router: its app-type check misses
  // MaterialApp on this Flutter version and falls back to pages without
  // transitions. MaterialPage follows the theme's page transitions.
  static Page<void> _page(GoRouterState state, Widget child) => MaterialPage(
    key: state.pageKey,
    name: state.name ?? state.path,
    arguments: {...state.pathParameters, ...state.uri.queryParameters},
    restorationId: state.pageKey.value,
    child: child,
  );

  // A step opened without its arguments (deep link, restored route) restarts
  // at Onboarding instead of crashing.
  static GoRoute _routeWithArgs<T>(String path, Widget Function(T) build) =>
      GoRoute(
        path: path,
        redirect: (_, state) =>
            state.extra is T ? null : OnboardingPage.routePath,
        pageBuilder: (_, state) => _page(state, build(state.extra! as T)),
      );

  @disposeMethod
  void dispose() {
    router.dispose();
    _authNotifier.dispose();
  }
}
