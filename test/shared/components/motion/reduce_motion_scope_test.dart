import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/components/motion/reduce_motion_scope.dart';
import 'package:j_donuts/shared/styles/app_motion.dart';

void main() {
  late bool reduceMotion;

  Widget scope() => ReduceMotionScope(
    child: Builder(
      builder: (context) {
        reduceMotion = context.reduceMotion;
        return const SizedBox.shrink();
      },
    ),
  );

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher
        .clearAccessibilityFeaturesTestValue();
  });

  group('ReduceMotionScope', () {
    testWidgets('keeps animations on when no setting asks to reduce them', (
      tester,
    ) async {
      await tester.pumpWidget(scope());

      expect(reduceMotion, isFalse);
    });

    testWidgets('reduces motion when iOS Reduce Motion is on', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(reduceMotion: true);

      await tester.pumpWidget(scope());

      expect(reduceMotion, isTrue);
    });

    testWidgets('reduces motion when Android Remove animations is on', (
      tester,
    ) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);

      await tester.pumpWidget(scope());

      expect(reduceMotion, isTrue);
    });

    testWidgets('follows the setting when it changes while the app runs', (
      tester,
    ) async {
      await tester.pumpWidget(scope());
      expect(reduceMotion, isFalse);

      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(reduceMotion: true);
      await tester.pump();

      expect(reduceMotion, isTrue);
    });
  });
}
