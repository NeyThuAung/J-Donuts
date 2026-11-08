import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../features/auth/presentation/cubit/authentication_cubit.dart';
import '../features/auth/presentation/pages/onboarding/onboarding_page.dart';
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

  // Reachable while signed out; every other route needs a session.
  static const publicRoutes = {OnboardingPage.routePath};

  late final _authNotifier = AuthenticationRouterNotifier(_authCubit.stream);

  late final GoRouter router = GoRouter(
    navigatorKey: _keyProvider.navigatorKey,
    refreshListenable: _authNotifier,
    initialLocation: IndexPage.routePath,
    redirect: (_, state) =>
        redirectFor(_authCubit.state, state.matchedLocation),
    routes: [
      GoRoute(
        path: OnboardingPage.routePath,
        builder: (_, _) => const OnboardingPage(),
      ),
      GoRoute(
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
      ),
    ],
  );

  static String? redirectFor(AuthenticationState auth, String location) {
    final isPublic = publicRoutes.contains(location);
    return switch (auth) {
      AuthenticationUnknown() => null,
      AuthenticationUnauthenticated() =>
        isPublic ? null : OnboardingPage.routePath,
      Authenticated() => isPublic ? IndexPage.routePath : null,
    };
  }

  @disposeMethod
  void dispose() {
    router.dispose();
    _authNotifier.dispose();
  }
}
