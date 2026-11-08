import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/presentation/pages/onboarding/onboarding_page.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/navigation/navigation.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:j_donuts/shared/styles/styles.dart';

import '../../../../../helpers/test_app.dart';
import '../../../../../helpers/test_authentication_cubit.dart';
import '../../../../../helpers/test_page_cubits.dart';

void main() {
  late TestAuthenticationCubit authCubit;
  late NavigationRouter navigationRouter;

  setUp(() {
    registerPageCubits();
    authCubit = TestAuthenticationCubit()..signOut();
    navigationRouter = NavigationRouter(NavigationKeyProvider(), authCubit);
  });

  tearDown(() async {
    navigationRouter.dispose();
    await authCubit.close();
  });

  Future<void> pumpOnboarding(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    double textScale = 1,
    bool reduceMotion = false,
  }) async {
    await tester.pumpWidget(
      MaterialApp.router(
        locale: locale,
        theme: AppTheme.light(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: navigationRouter.router,
        builder: (context, app) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
            disableAnimations: reduceMotion,
          ),
          child: app!,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('OnboardingPage', () {
    testWidgets('shows the title, both entry points and social sign-in', (
      tester,
    ) async {
      await pumpOnboarding(tester);

      expect(find.byType(OnboardingPage), findsOneWidget);
      expect(find.text('Round food for every mood'), findsOneWidget);
      expect(find.text("LET'S GET STARTED"), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);
      expect(find.byTooltip('Continue with Google'), findsOneWidget);
      expect(find.byTooltip('Continue with Apple'), findsOneWidget);
      expect(find.byTooltip('Continue with Facebook'), findsOneWidget);
    });

    testWidgets("Let's get started opens the phone step to register", (
      tester,
    ) async {
      await pumpOnboarding(tester);

      await tester.tap(find.text("LET'S GET STARTED"));
      await tester.pumpAndSettle();

      expect(phoneFlowOf(tester), AuthFlow.register);
    });

    testWidgets('Log In opens the phone step to log in', (tester) async {
      await pumpOnboarding(tester);

      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      expect(phoneFlowOf(tester), AuthFlow.logIn);
    });

    testWidgets('social sign-in shows a not-in-demo sheet', (tester) async {
      await pumpOnboarding(tester);

      await tester.tap(find.byTooltip('Continue with Apple'));
      await tester.pumpAndSettle();

      expect(find.byType(ComingSoonSheet), findsOneWidget);
      expect(find.text('Continue with Apple'), findsWidgets);
      expect(
        find.text("This isn't available in the demo yet."),
        findsOneWidget,
      );

      await tester.tap(find.text('CLOSE'));
      await tester.pumpAndSettle();
      expect(find.byType(ComingSoonSheet), findsNothing);
    });

    testWidgets('Terms of Use shows a not-in-demo sheet', (tester) async {
      await pumpOnboarding(tester);

      await tester.tap(find.text('Terms of Use'));
      await tester.pumpAndSettle();

      expect(find.byType(ComingSoonSheet), findsOneWidget);
    });

    testWidgets('the content fades in after the donuts', (tester) async {
      await tester.pumpWidget(Container());
      final router = navigationRouter.router;
      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.light(const Locale('en')),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      );
      await tester.pump();

      double titleOpacity() => tester
          .widget<FadeTransition>(
            find
                .ancestor(
                  of: find.text('Round food for every mood'),
                  matching: find.byType(FadeTransition),
                )
                .first,
          )
          .opacity
          .value;

      expect(titleOpacity(), 0);
      await tester.pumpAndSettle();
      expect(titleOpacity(), 1);
    });

    testWidgets('shows everything at once under Reduce Motion', (
      tester,
    ) async {
      await pumpOnboarding(tester, reduceMotion: true);
      await tester.pump();

      final fade = tester.widget<FadeTransition>(
        find
            .ancestor(
              of: find.text('Round food for every mood'),
              matching: find.byType(FadeTransition),
            )
            .first,
      );
      expect(fade.opacity.value, 1);
    });

    for (final locale in const [Locale('en'), Locale('my')]) {
      testWidgets(
        'fits the smallest phone at text scale 1.3 in ${locale.languageCode}',
        (tester) async {
          useScreenSize(tester, smallestPhone);
          await pumpOnboarding(
            tester,
            locale: locale,
            textScale: maxTextScale,
          );

          expect(tester.takeException(), isNull);
          await tester.ensureVisible(find.byType(AppButton));
          await tester.pumpAndSettle();
          expect(find.byType(AppButton).hitTestable(), findsOneWidget);
        },
      );
    }
  });
}
