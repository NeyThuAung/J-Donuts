import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/components/button/app_button.dart';
import 'package:j_donuts/shared/styles/styles.dart';

import '../../../helpers/test_app.dart';

Widget _button({VoidCallback? onPressed, bool isLoading = false}) => Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(24),
    child: AppButton(
      label: 'Continue',
      onPressed: onPressed,
      isLoading: isLoading,
    ),
  ),
);

Size _pillSize(WidgetTester tester) => tester.getSize(
  find.descendant(
    of: find.byType(AppButton),
    matching: find.byType(AnimatedContainer),
  ),
);

void main() {
  group('AppButton', () {
    testWidgets('shows the label in capitals and calls onPressed on tap', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(testApp(_button(onPressed: () => taps++)));

      await tester.tap(find.text('CONTINUE'));

      expect(taps, 1);
    });

    testWidgets('ignores taps and greys out when disabled', (tester) async {
      await tester.pumpWidget(testApp(_button()));

      await tester.tap(find.text('CONTINUE'));
      await tester.pumpAndSettle();

      final pill = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      const colors = AppThemeColors.light;
      expect((pill.decoration! as ShapeDecoration).color, colors.disabled);
    });

    testWidgets('ignores a second tap while loading', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        testApp(_button(onPressed: () => taps++, isLoading: true)),
      );

      await tester.tap(find.byType(AppButton));

      expect(taps, 0);
    });

    testWidgets('morphs into a round spinner while loading', (tester) async {
      await tester.pumpWidget(testApp(_button(onPressed: () {})));
      final fullWidth = _pillSize(tester).width;

      await tester.pumpWidget(
        testApp(_button(onPressed: () {}, isLoading: true)),
      );
      await tester.pump(AppMotion.buttonMorph ~/ 2);
      final midWidth = _pillSize(tester).width;
      await tester.pump(AppMotion.buttonMorph);

      final height = $styles.size.buttonHeight;
      expect(midWidth, inExclusiveRange(height, fullWidth));
      expect(_pillSize(tester), Size.square(height));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('CONTINUE'), findsNothing);
    });

    testWidgets('morphs at once under Reduce Motion', (tester) async {
      await tester.pumpWidget(
        testApp(_button(onPressed: () {}), reduceMotion: true),
      );
      await tester.pumpWidget(
        testApp(
          _button(onPressed: () {}, isLoading: true),
          reduceMotion: true,
        ),
      );
      await tester.pump();

      expect(_pillSize(tester), Size.square($styles.size.buttonHeight));
    });

    testWidgets('scales down while pressed and back on release', (
      tester,
    ) async {
      await tester.pumpWidget(testApp(_button(onPressed: () {})));
      double scale() =>
          tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale;

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(AppButton)),
      );
      await tester.pump();
      expect(scale(), AppMotion.pressedScale);

      await gesture.up();
      await tester.pump();
      expect(scale(), 1);
    });

    testWidgets('does not scale when pressed while disabled', (tester) async {
      await tester.pumpWidget(testApp(_button()));

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(AppButton)),
      );
      await tester.pump();

      expect(
        tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale,
        1,
      );
      await gesture.up();
    });
  });
}
