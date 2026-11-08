import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/gen/fonts.gen.dart';
import 'package:j_donuts/shared/styles/styles.dart';

void main() {
  group('AppTheme.light', () {
    test('uses Figtree for English', () {
      final theme = AppTheme.light(const Locale('en'));

      expect(theme.textTheme.bodyMedium?.fontFamily, FontFamily.figtree);
    });

    test('uses Noto Sans Myanmar with taller lines for Burmese', () {
      final theme = AppTheme.light(const Locale('my'));
      final body = theme.textTheme.bodyMedium;

      expect(body?.fontFamily, FontFamily.notoSansMyanmar);
      expect(body?.height, greaterThan(1));
    });

    testWidgets('exposes AppThemeColors through context.appColors', (
      tester,
    ) async {
      late AppThemeColors colors;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(const Locale('en')),
          home: Builder(
            builder: (context) {
              colors = context.appColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(colors, AppThemeColors.light);
    });
  });

  group('AppThemeColors', () {
    const other = AppThemeColors.light;
    final changed = other.copyWith(primary: AppColors.pink);

    test('copyWith replaces only the given colour', () {
      expect(changed.primary, AppColors.pink);
      expect(changed.accent, other.accent);
    });

    test('lerp returns the start at 0 and the end at 1', () {
      expect(other.lerp(changed, 0).primary, other.primary);
      expect(other.lerp(changed, 1).primary, changed.primary);
    });
  });
}
