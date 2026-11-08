import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/date_of_birth/date_of_birth_page.dart';
import 'package:j_donuts/features/auth/presentation/pages/name/name_page.dart';
import 'package:j_donuts/features/auth/presentation/pages/onboarding/onboarding_page.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/phone_number_page.dart';
import 'package:j_donuts/features/auth/presentation/pages/verify_otp/verify_otp_page.dart';
import 'package:j_donuts/features/auth/presentation/pages/welcome/welcome_page.dart';
import 'package:j_donuts/features/product/presentation/pages/product_detail/product_detail_page.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/navigation/navigation.dart';
import 'package:j_donuts/shared/styles/styles.dart';

import '../helpers/test_authentication_cubit.dart';

const _unknown = AuthenticationState.unknown();
const _signedOut = AuthenticationState.unauthenticated();
const _signedIn = AuthenticationState.authenticated(userId: testUserId);
const _newMember = AuthenticationState.authenticated(
  userId: testUserId,
  isNewMember: true,
);
const _phone = '+959254135592';

void main() {
  group('NavigationRouter.redirectFor', () {
    test('stays put while the session check is running', () {
      expect(NavigationRouter.redirectFor(_unknown, '/'), isNull);
      expect(NavigationRouter.redirectFor(_unknown, '/product/p1'), isNull);
    });

    test('sends a signed-out user from any guarded route to onboarding', () {
      for (final location in ['/', '/product/p1', WelcomePage.routePath]) {
        expect(
          NavigationRouter.redirectFor(_signedOut, location),
          OnboardingPage.routePath,
        );
      }
    });

    test('lets a signed-out user move through every sign-up step', () {
      for (final location in NavigationRouter.publicRoutes) {
        expect(NavigationRouter.redirectFor(_signedOut, location), isNull);
      }
    });

    test(
      'sends a returning member from the auth steps and Welcome to Home',
      () {
        for (final location in {
          ...NavigationRouter.publicRoutes,
          WelcomePage.routePath,
        }) {
          expect(
            NavigationRouter.redirectFor(_signedIn, location),
            IndexPage.routePath,
          );
        }
      },
    );

    test('sends a new member to Welcome from anywhere', () {
      for (final location in [DateOfBirthPage.routePath, '/', '/product/p1']) {
        expect(
          NavigationRouter.redirectFor(_newMember, location),
          WelcomePage.routePath,
        );
      }
    });

    test('lets a new member stay on Welcome', () {
      expect(
        NavigationRouter.redirectFor(_newMember, WelcomePage.routePath),
        isNull,
      );
    });

    test('lets a signed-in user open guarded routes', () {
      expect(NavigationRouter.redirectFor(_signedIn, '/'), isNull);
      expect(NavigationRouter.redirectFor(_signedIn, '/product/p1'), isNull);
    });
  });

  group('NavigationRouter', () {
    late TestAuthenticationCubit authCubit;
    late NavigationRouter navigationRouter;

    setUp(() {
      authCubit = TestAuthenticationCubit();
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

    testWidgets('pushes the phone step with its flow over onboarding', (
      tester,
    ) async {
      authCubit.signOut();
      await pumpApp(tester);

      unawaited(
        tester
            .element(find.byType(OnboardingPage))
            .pushPhoneNumberPage(flow: AuthFlow.logIn),
      );
      await tester.pumpAndSettle();

      final page = tester.widget<PhoneNumberPage>(find.byType(PhoneNumberPage));
      expect(page.flow, AuthFlow.logIn);
      expect(location(), '/phone-number?flow=logIn');

      navigationRouter.router.pop();
      await tester.pumpAndSettle();
      expect(find.byType(OnboardingPage), findsOneWidget);
    });

    testWidgets('starts the register flow for an unknown flow value', (
      tester,
    ) async {
      authCubit.signOut();
      await pumpApp(tester);

      navigationRouter.router.go('/phone-number?flow=other');
      await tester.pumpAndSettle();

      final page = tester.widget<PhoneNumberPage>(find.byType(PhoneNumberPage));
      expect(page.flow, AuthFlow.register);
    });

    testWidgets('passes the typed arguments to each sign-up step', (
      tester,
    ) async {
      authCubit.signOut();
      await pumpApp(tester);
      final context = tester.element(find.byType(OnboardingPage));

      unawaited(
        context.pushVerifyOtpPage(
          const VerifyOtpArgs(phone: _phone, flow: AuthFlow.register),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        tester.widget<VerifyOtpPage>(find.byType(VerifyOtpPage)).args.phone,
        _phone,
      );

      unawaited(context.pushNamePage(const NameArgs(phone: _phone)));
      await tester.pumpAndSettle();
      expect(find.byType(NamePage), findsOneWidget);

      unawaited(
        context.pushDateOfBirthPage(
          const DateOfBirthArgs(phone: _phone, firstName: 'Ye Min'),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<DateOfBirthPage>(find.byType(DateOfBirthPage))
            .args
            .firstName,
        'Ye Min',
      );
    });

    testWidgets('restarts at onboarding when a step opens without arguments', (
      tester,
    ) async {
      authCubit.signOut();
      await pumpApp(tester);

      for (final step in [
        VerifyOtpPage.routePath,
        NamePage.routePath,
        DateOfBirthPage.routePath,
      ]) {
        navigationRouter.router.go(step);
        await tester.pumpAndSettle();

        expect(find.byType(OnboardingPage), findsOneWidget, reason: step);
      }
    });

    testWidgets('shows Welcome once to a new member, then Home', (
      tester,
    ) async {
      authCubit.signOut();
      await pumpApp(tester);

      authCubit.signIn(isNewMember: true);
      await tester.pumpAndSettle();
      expect(find.byType(WelcomePage), findsOneWidget);

      authCubit.welcomeSeen();
      await tester.pumpAndSettle();
      expect(find.byType(IndexPage), findsOneWidget);
      expect(location(), IndexPage.routePath);
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
