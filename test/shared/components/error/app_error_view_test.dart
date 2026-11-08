import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/shared/components/error/app_error_view.dart';
import 'package:j_donuts/shared/styles/styles.dart';

const _smallestPhone = Size(320, 568);
const _maxTextScale = 1.3;

Widget _app(Widget child, {Locale locale = const Locale('en')}) => MaterialApp(
  locale: locale,
  theme: AppTheme.light(locale),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

void main() {
  group('AppErrorView', () {
    testWidgets('shows the default localized title and message', (
      tester,
    ) async {
      await tester.pumpWidget(_app(const AppErrorView()));

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(
        find.text('Something went wrong. Please try again.'),
        findsOneWidget,
      );
    });

    testWidgets('shows the Burmese defaults in the my locale', (tester) async {
      await tester.pumpWidget(
        _app(const AppErrorView(), locale: const Locale('my')),
      );

      expect(find.text('တစ်ခုခု မှားယွင်းနေပါသည်'), findsOneWidget);
    });

    testWidgets('shows a custom icon, title and message for empty states', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const AppErrorView(
            icon: CupertinoIcons.bag,
            title: 'No donuts yet',
            message: 'Check back soon.',
          ),
        ),
      );

      expect(find.byIcon(CupertinoIcons.bag), findsOneWidget);
      expect(find.text('No donuts yet'), findsOneWidget);
      expect(find.text('Check back soon.'), findsOneWidget);
    });

    testWidgets('hides Retry when no retry callback is given', (tester) async {
      await tester.pumpWidget(_app(const AppErrorView()));

      expect(find.text('Retry'), findsNothing);
    });

    testWidgets('calls the retry callback when Retry is tapped', (
      tester,
    ) async {
      var retries = 0;
      await tester.pumpWidget(_app(AppErrorView(onRetry: () => retries++)));

      await tester.tap(find.text('Retry'));

      expect(retries, 1);
    });

    testWidgets('Retry meets the minimum tap target', (tester) async {
      await tester.pumpWidget(_app(AppErrorView(onRetry: () {})));

      final size = tester.getSize(find.byType(TextButton));
      expect(size.height, greaterThanOrEqualTo($styles.size.minTapTarget));
    });

    testWidgets(
      'fits a small phone at text scale 1.3 with long Burmese text',
      (tester) async {
        tester.view.physicalSize = _smallestPhone;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(
              size: _smallestPhone,
              textScaler: TextScaler.linear(_maxTextScale),
            ),
            child: _app(
              AppErrorView(onRetry: () {}),
              locale: const Locale('my'),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      },
    );
  });
}
