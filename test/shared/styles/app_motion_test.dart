import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/styles/styles.dart';

void main() {
  group('shakeOffset', () {
    test('rests at the start and the end', () {
      expect(shakeOffset(0), 0);
      expect(shakeOffset(1), closeTo(0, 1e-9));
    });

    test('moves away from rest in between', () {
      expect(
        shakeOffset(1 / 12).abs(),
        greaterThan(AppMotion.shakeDistance / 2),
      );
    });
  });

  group('staggerInterval', () {
    test('starts later for each following item', () {
      expect(staggerInterval(1).begin, greaterThan(staggerInterval(0).begin));
    });

    test('stays inside the controller range for items past the cap', () {
      final last = staggerInterval(AppMotion.maxStaggeredItems + 5);

      expect(last.begin, lessThan(1));
      expect(last.end, lessThanOrEqualTo(1));
    });
  });

  group('context.motion', () {
    Future<Duration> resolve(
      WidgetTester tester, {
      required bool reduce,
    }) async {
      late Duration result;
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(disableAnimations: reduce),
          child: Builder(
            builder: (context) {
              result = context.motion(AppMotion.entrance);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      return result;
    }

    testWidgets('returns the full duration normally', (tester) async {
      expect(await resolve(tester, reduce: false), AppMotion.entrance);
    });

    testWidgets('returns zero when Reduce Motion is on', (tester) async {
      expect(await resolve(tester, reduce: true), Duration.zero);
    });
  });
}
