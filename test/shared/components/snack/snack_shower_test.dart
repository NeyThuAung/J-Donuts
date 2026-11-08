import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/navigation/navigation_key_provider.dart';
import 'package:j_donuts/shared/components/snack/app_snack.dart';
import 'package:j_donuts/shared/components/snack/snack_shower.dart';
import 'package:j_donuts/shared/styles/styles.dart';

void main() {
  group('SnackShower', () {
    late NavigationKeyProvider keyProvider;
    late SnackShower shower;

    setUp(() {
      keyProvider = NavigationKeyProvider();
      shower = SnackShower(keyProvider);
    });

    Future<void> pumpApp(
      WidgetTester tester, {
      Locale locale = const Locale('en'),
    }) => tester.pumpWidget(
      MaterialApp(
        navigatorKey: keyProvider.navigatorKey,
        locale: locale,
        theme: AppTheme.light(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(),
      ),
    );

    Future<void> showAndExpect(
      WidgetTester tester,
      void Function() show, {
      required String text,
      required SnackType type,
    }) async {
      show();
      await tester.pumpAndSettle();

      expect(find.text(text), findsOneWidget);
      expect(tester.widget<AppSnack>(find.byType(AppSnack)).type, type);

      await tester.pump(AppMotion.snackDisplay);
      await tester.pumpAndSettle();
      expect(find.text(text), findsNothing);
    }

    testWidgets('info shows the localized message as an info snack', (
      tester,
    ) async {
      await pumpApp(tester);

      await showAndExpect(
        tester,
        () => shower.info((l10n) => l10n.commonContinue),
        text: 'Continue',
        type: SnackType.info,
      );
    });

    testWidgets('success shows the localized message as a success snack', (
      tester,
    ) async {
      await pumpApp(tester);

      await showAndExpect(
        tester,
        () => shower.success((l10n) => l10n.commonRetry),
        text: 'Retry',
        type: SnackType.success,
      );
    });

    testWidgets('error maps the failure to its localized message', (
      tester,
    ) async {
      await pumpApp(tester);

      await showAndExpect(
        tester,
        () => shower.error(const ConnectionFailure()),
        text: 'No internet connection.',
        type: SnackType.error,
      );
    });

    testWidgets('resolves the message in the current locale', (tester) async {
      await pumpApp(tester, locale: const Locale('my'));

      await showAndExpect(
        tester,
        () => shower.error(const ConnectionFailure()),
        text: 'အင်တာနက် ချိတ်ဆက်မှု မရှိပါ။',
        type: SnackType.error,
      );
    });

    test('does nothing when the app has not mounted a navigator', () {
      expect(() => shower.info((l10n) => l10n.commonRetry), returnsNormally);
      expect(() => shower.error(const ServerFailure()), returnsNormally);
    });
  });
}
