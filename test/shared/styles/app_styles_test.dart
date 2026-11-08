import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/styles/styles.dart';

void main() {
  group('ScreenType.fromSize', () {
    test('returns sm for every phone size and an unknown size', () {
      expect(ScreenType.fromSize(null), ScreenType.sm);
      expect(ScreenType.fromSize(const Size(375, 667)), ScreenType.sm);
      expect(ScreenType.fromSize(const Size(440, 956)), ScreenType.sm);
    });

    test('returns md for a large tablet', () {
      expect(ScreenType.fromSize(const Size(820, 1180)), ScreenType.md);
    });

    test('returns lg for the largest tablets', () {
      expect(ScreenType.fromSize(const Size(1024, 1366)), ScreenType.lg);
    });
  });

  group('updateStylesForScreen', () {
    tearDown(() => $styles = AppStyles());

    test('scales insets when the screen type changes', () {
      updateStylesForScreen(const Size(1024, 1366));

      expect($styles.screenType, ScreenType.lg);
      expect($styles.insets.md, 16 * ScreenType.lg.scale);
    });

    test('keeps the same instance when the screen type is unchanged', () {
      final before = $styles;

      updateStylesForScreen(const Size(390, 844));

      expect($styles, same(before));
    });
  });
}
