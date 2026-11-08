import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';

abstract final class AppTypography {
  static const _myanmarLanguageCode = 'my';
  // Latin button labels only: spacing breaks Myanmar glyph clusters apart.
  static const _buttonLetterSpacing = 1.2;

  // Myanmar marks stack above and below letters; normal line height clips them.
  static const _myanmarLineHeight = 1.7;

  static TextTheme textTheme(Locale locale, Color color) {
    final isMyanmar = locale.languageCode == _myanmarLanguageCode;
    final base = TextStyle(
      fontFamily: isMyanmar ? FontFamily.notoSansMyanmar : FontFamily.figtree,
      fontFamilyFallback: const [
        FontFamily.figtree,
        FontFamily.notoSansMyanmar,
      ],
      color: color,
      height: isMyanmar ? _myanmarLineHeight : null,
      leadingDistribution: TextLeadingDistribution.even,
    );
    TextStyle style(double size, FontWeight weight) =>
        base.copyWith(fontSize: size, fontWeight: weight);

    return TextTheme(
      displaySmall: style(32, FontWeight.w700),
      headlineMedium: style(28, FontWeight.w700),
      headlineSmall: style(24, FontWeight.w700),
      titleLarge: style(20, FontWeight.w600),
      titleMedium: style(16, FontWeight.w600),
      titleSmall: style(14, FontWeight.w700),
      bodyLarge: style(16, FontWeight.w400),
      bodyMedium: style(14, FontWeight.w400),
      bodySmall: style(12, FontWeight.w400),
      labelLarge: style(
        14,
        FontWeight.w800,
      ).copyWith(letterSpacing: isMyanmar ? null : _buttonLetterSpacing),
      labelMedium: style(12, FontWeight.w600),
      labelSmall: style(10, FontWeight.w600),
    );
  }
}
