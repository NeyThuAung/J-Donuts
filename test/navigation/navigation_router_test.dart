import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/onboarding/onboarding_page.dart';
import 'package:j_donuts/features/product/presentation/pages/product_detail/product_detail_page.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/navigation/navigation.dart';
import 'package:j_donuts/shared/styles/styles.dart';

const _unknown = AuthenticationState.unknown();
const _signedOut = AuthenticationState.unauthenticated();
const _signedIn = AuthenticationState.authenticated(userId: 'u1');

// The real cubit can only sign out until Task 1; this one can sign in.
class _TestAuthenticationCubit extends AuthenticationCubit {
  void signIn() => emit(_signedIn);
  void signOut() => emit(_signedOut);
}

void main() {
  group('NavigationRouter.redirectFor', () {
    test('stays put while the session check is running', () {
      expect(NavigationRouter.redirectFor(_unknown, '/'), isNull);
      expect(NavigationRouter.redirectFor(_unknown, '/product/p1'), isNull);
    });

    test('sends a signed-out user from any guarded route to onboarding', () {
      for (final location in ['/', '/product/p1']) {
        expect(
          NavigationRouter.redirectFor(_signedOut, location),
          OnboardingPage.routePath,
        );
      }
    });

    test('lets a signed-out user stay on a public route', () {
      expect(
        NavigationRouter.redirectFor(_signedOut, OnboardingPage.routePath),
        isNull,
      );
    });

    test('sends a signed-in user away from public routes to Home', () {
      expect(
        NavigationRouter.redirectFor(_signedIn, OnboardingPage.routePath),
        IndexPage.routePath,
      );
    });

    test('lets a signed-in user open guarded routes', () {
      expect(NavigationRouter.redirectFor(_signedIn, '/'), isNull);
      expect(NavigationRouter.redirectFor(_signedIn, '/product/p1'), isNull);
    });
  });

  group('NavigationRouter', () {
    late _TestAuthenticationCubit authCubit;
    late NavigationRouter navigationRouter;

    setUp(() {
      authCubit = _TestAuthenticationCubit();
      navigationRouter = NavigationRouter(NavigationKeyProvider(), authCubit);
    });

    tearDown(() async {
      navigationRouter.dispose();
      await authCubit.close();
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.light(const Locale('en')),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: navigationRouter.router,
        ),
      );
      await tester.pumpAndSettle();
    }

    // The top route's location, including pushed routes.
    String location() => navigationRouter.router.state.uri.toString();

    testWidgets('moves to onboarding when the session check signs out', (
      tester,
    ) async {
      await pumpApp(tester);

      await authCubit.checkSession();
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingPage), findsOneWidget);
      expect(location(), OnboardingPage.routePath);
    });

    testWidgets('moves from onboarding to Home when the user signs in', (
      tester,
    ) async {
      authCubit.signOut();
      await pumpApp(tester);
      expect(find.byType(OnboardingPage), findsOneWidget);

      authCubit.signIn();
      await tester.pumpAndSettle();

      expect(find.byType(IndexPage), findsOneWidget);
      expect(location(), IndexPage.routePath);
    });

    testWidgets('opens the tab named in the location', (tester) async {
      authCubit.signIn();
      await pumpApp(tester);

      navigationRouter.router.go('/?tab=rewards');
      await tester.pumpAndSettle();

      expect(
        tester.widget<IndexPage>(find.byType(IndexPage)).tab,
        IndexTab.rewards,
      );
    });

    testWidgets('pushes product detail with its id over the current tab', (
      tester,
    ) async {
      authCubit.signIn();
      await pumpApp(tester);
      tester.element(find.byType(IndexPage)).selectIndexTab(IndexTab.rewards);
      await tester.pumpAndSettle();

      // Completes only when the page is popped, so it is not awaited.
      unawaited(
        tester
            .element(find.byType(IndexPage))
            .pushProductDetailPage(productId: 'p_coconut'),
      );
      await tester.pumpAndSettle();

      final page = tester.widget<ProductDetailPage>(
        find.byType(ProductDetailPage),
      );
      expect(page.productId, 'p_coconut');
      expect(location(), '/product/p_coconut');

      navigationRouter.router.pop();
      await tester.pumpAndSettle();
      expect(
        tester.widget<IndexPage>(find.byType(IndexPage)).tab,
        IndexTab.rewards,
      );
    });

    testWidgets('sends the user to onboarding when they sign out', (
      tester,
    ) async {
      authCubit.signIn();
      await pumpApp(tester);

      authCubit.signOut();
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingPage), findsOneWidget);
    });

    testWidgets('uses the shared root navigator key', (tester) async {
      final keyProvider = NavigationKeyProvider();
      final router = NavigationRouter(keyProvider, authCubit);
      addTearDown(router.dispose);

      expect(
        router.router.routerDelegate.navigatorKey,
        keyProvider.navigatorKey,
      );
    });
  });
}
