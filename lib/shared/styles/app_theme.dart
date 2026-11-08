import 'package:flutter/material.dart';

import 'app_styles.dart';
import 'app_theme_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData light(Locale locale) {
    const colors = AppThemeColors.light;
    final textTheme = AppTypography.textTheme(locale, colors.textPrimary);

    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme(colors),
      scaffoldBackgroundColor: colors.background,
      textTheme: textTheme,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      elevatedButtonTheme: _elevatedButtonTheme(colors, textTheme),
      inputDecorationTheme: _inputTheme(colors, textTheme),
      extensions: const [colors],
    );
  }

  static ColorScheme _colorScheme(AppThemeColors colors) => ColorScheme.light(
    primary: colors.primary,
    onPrimary: colors.onPrimary,
    secondary: colors.accent,
    onSecondary: colors.onPrimary,
    tertiary: colors.highlight,
    surface: colors.surface,
    onSurface: colors.textPrimary,
    onSurfaceVariant: colors.textSecondary,
  );

  static ElevatedButtonThemeData _elevatedButtonTheme(
    AppThemeColors colors,
    TextTheme textTheme,
  ) => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: colors.primary,
      foregroundColor: colors.onPrimary,
      disabledBackgroundColor: colors.disabled,
      disabledForegroundColor: colors.onPrimary,
      minimumSize: Size.fromHeight($styles.size.buttonHeight),
      textStyle: textTheme.labelLarge,
      shape: const StadiumBorder(),
    ),
  );

  static InputDecorationTheme _inputTheme(
    AppThemeColors colors,
    TextTheme textTheme,
  ) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular($styles.corner.xs),
      borderSide: BorderSide.none,
    );
    return InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      hintStyle: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
      contentPadding: EdgeInsets.all($styles.insets.md),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: colors.primary),
      ),
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: colors.accent),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(color: colors.accent),
      ),
      errorStyle: textTheme.bodySmall?.copyWith(color: colors.accent),
    );
  }
}
