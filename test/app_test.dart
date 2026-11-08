import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/app.dart';
import 'package:j_donuts/features/auth/presentation/pages/onboarding/onboarding_page.dart';
import 'package:j_donuts/gen/fonts.gen.dart';
import 'package:j_donuts/navigation/navigation.dart';

import 'helpers/test_authentication_cubit.dart';

const _systemTextScale = 2.0;
const _sampleFontSize = 10.0;

void main() {
  group('App', () {
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
        App(authCubit: authCubit, router: navigationRouter.router),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('opens onboarding when no one is signed in', (tester) async {
      await authCubit.checkSession();
      await pumpApp(tester);

      expect(find.byType(OnboardingPage), findsOneWidget);
      expect(find.text('Coming soon'), findsOneWidget);
    });

    testWidgets('opens the Home tab when a user is signed in', (tester) async {
      authCubit.signIn();
      await pumpApp(tester);

      expect(
        tester.widget<IndexPage>(find.byType(IndexPage)).tab,
        IndexTab.home,
      );
    });

    testWidgets('shows Burmese text in the Myanmar font on a Burmese phone', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = [const Locale('my')];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      await authCubit.checkSession();
      await pumpApp(tester);

      final context = tester.element(find.byType(OnboardingPage));
      expect(
        find.text('စိတ်ခံစားမှုတိုင်းအတွက် အဝိုင်းလေးများ'),
        findsOneWidget,
      );
      expect(
        Theme.of(context).textTheme.bodyMedium?.fontFamily,
        FontFamily.notoSansMyanmar,
      );
    });

    testWidgets('falls back to English for an unsupported phone language', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = [const Locale('fr')];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      await authCubit.checkSession();
      await pumpApp(tester);

      final context = tester.element(find.byType(OnboardingPage));
      expect(find.text('Coming soon'), findsOneWidget);
      expect(
        Theme.of(context).textTheme.bodyMedium?.fontFamily,
        FontFamily.figtree,
      );
    });

    testWidgets('caps a large system text size at 1.3', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = _systemTextScale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await authCubit.checkSession();
      await pumpApp(tester);

      final context = tester.element(find.byType(OnboardingPage));
      expect(
        MediaQuery.textScalerOf(context).scale(_sampleFontSize),
        closeTo(_sampleFontSize * App.maxTextScale, 0.001),
      );
    });
  });
}
