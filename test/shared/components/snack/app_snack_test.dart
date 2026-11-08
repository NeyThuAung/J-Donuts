import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/components/snack/app_snack.dart';
import 'package:j_donuts/shared/styles/styles.dart';

const _message = 'Coming soon';
const _colors = AppThemeColors.light;
// The display timer starts only after the entrance finishes.
Future<void> _waitForSnackToLeave(WidgetTester tester) async {
  await tester.pump(AppMotion.snackDisplay);
  await tester.pumpAndSettle();
}

Widget _app({Widget? home, bool disableAnimations = false}) => MaterialApp(
  theme: AppTheme.light(const Locale('en')),
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(
      context,
    ).copyWith(disableAnimations: disableAnimations),
    child: child!,
  ),
  home: Scaffold(body: home ?? const SizedBox.shrink()),
);

Icon _iconOf(WidgetTester tester) => tester.widget<Icon>(
  find.descendant(of: find.byType(AppSnack), matching: find.byType(Icon)),
);

void main() {
  group('AppSnack', () {
    final cases = {
      SnackType.info: (CupertinoIcons.info_circle_fill, _colors.primary),
      SnackType.success: (
        CupertinoIcons.checkmark_circle_fill,
        _colors.success,
      ),
      SnackType.error: (
        CupertinoIcons.exclamationmark_circle_fill,
        _colors.accent,
      ),
    };

    for (final MapEntry(key: type, value: (icon, color)) in cases.entries) {
      testWidgets('shows the ${type.name} icon in its colour with the text', (
        tester,
      ) async {
        await tester.pumpWidget(
          _app(
            home: AppSnack(message: _message, type: type),
          ),
        );

        expect(find.text(_message), findsOneWidget);
        expect(_iconOf(tester).icon, icon);
        expect(_iconOf(tester).color, color);
      });
    }

    testWidgets('uses light text on the inverse surface', (tester) async {
      await tester.pumpWidget(
        _app(
          home: const AppSnack(message: _message, type: SnackType.error),
        ),
      );

      final text = tester.widget<Text>(find.text(_message));
      expect(text.style?.color, _colors.onInverseSurface);
      expect(text.maxLines, isNotNull);
    });
  });

  group('showAppSnack', () {
    Future<void> show(WidgetTester tester) async {
      final overlay = tester.state<NavigatorState>(find.byType(Navigator));
      showAppSnack(overlay.overlay!, message: _message, type: SnackType.info);
      await tester.pump();
    }

    testWidgets('shows the snack, then removes it after the display time', (
      tester,
    ) async {
      await tester.pumpWidget(_app());
      await show(tester);
      await tester.pumpAndSettle();

      expect(find.text(_message), findsOneWidget);

      await _waitForSnackToLeave(tester);
      expect(find.text(_message), findsNothing);
    });

    testWidgets('appears without an entrance animation under Reduce Motion', (
      tester,
    ) async {
      await tester.pumpWidget(_app(disableAnimations: true));
      await show(tester);
      await tester.pump();

      expect(tester.binding.hasScheduledFrame, isFalse);
      expect(tester.getRect(find.byType(AppSnack)).top, greaterThan(0));

      await _waitForSnackToLeave(tester);
      expect(find.text(_message), findsNothing);
    });
  });
}
