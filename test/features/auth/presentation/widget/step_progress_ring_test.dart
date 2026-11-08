import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/presentation/widget/auth_step.dart';
import 'package:j_donuts/features/auth/presentation/widget/step_progress_ring.dart';
import 'package:j_donuts/shared/styles/styles.dart';

import '../../../../helpers/test_app.dart';

double _ringValue(WidgetTester tester) {
  final paint = tester.widget<CustomPaint>(
    find.descendant(
      of: find.byType(StepProgressRing),
      matching: find.byType(CustomPaint),
    ),
  );
  return (paint.painter! as StepRingPainter).value;
}

Future<void> _pumpRing(
  WidgetTester tester,
  AuthStep step, {
  bool reduceMotion = false,
}) => tester.pumpWidget(
  testApp(
    Scaffold(
      body: Center(child: StepProgressRing(step: step)),
    ),
    reduceMotion: reduceMotion,
  ),
);

void main() {
  group('AuthStep', () {
    test('fills the ring by quarters: 25, 50, 75 and 100%', () {
      expect(AuthStep.values.map((step) => step.progress), [
        0.25,
        0.5,
        0.75,
        1.0,
      ]);
    });

    test('starts each step where the previous one ended', () {
      expect(AuthStep.otp.previousProgress, AuthStep.phone.progress);
      expect(AuthStep.phone.previousProgress, 0);
    });
  });

  group('StepProgressRing', () {
    testWidgets('sweeps from the previous step to this one', (tester) async {
      await _pumpRing(tester, AuthStep.name);
      expect(_ringValue(tester), AuthStep.otp.progress);

      await tester.pumpAndSettle();

      expect(_ringValue(tester), AuthStep.name.progress);
    });

    testWidgets('ends the last step past a full ring, as a check', (
      tester,
    ) async {
      await _pumpRing(tester, AuthStep.dateOfBirth);

      await tester.pumpAndSettle();

      expect(_ringValue(tester), greaterThan(1));
    });

    testWidgets('jumps to the end under Reduce Motion', (tester) async {
      await _pumpRing(tester, AuthStep.name, reduceMotion: true);
      await tester.pump();

      expect(_ringValue(tester), AuthStep.name.progress);
    });

    testWidgets('tells screen readers which step this is', (tester) async {
      await _pumpRing(tester, AuthStep.otp);

      expect(find.bySemanticsLabel('Step 2 of 4'), findsOneWidget);
    });
  });

  group('StepRingPainter', () {
    StepRingPainter painter(double value) => StepRingPainter(
      value: value,
      stroke: 5,
      trackColor: AppColors.skyBlue,
      progressColor: AppColors.pink,
      checkColor: AppColors.white,
    );

    test('repaints only when the value changes', () {
      expect(painter(0.5).shouldRepaint(painter(0.5)), isFalse);
      expect(painter(0.5).shouldRepaint(painter(0.75)), isTrue);
    });
  });
}
