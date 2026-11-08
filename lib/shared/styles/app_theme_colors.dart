import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.primary,
    required this.primaryTint,
    required this.onPrimary,
    required this.accent,
    required this.highlight,
    required this.textPrimary,
    required this.textSecondary,
    required this.surface,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.background,
    required this.surfaceMuted,
    required this.authGradientTop,
    required this.authGradientBottom,
    required this.homeHeader,
    required this.banner,
    required this.success,
    required this.progressSecondary,
    required this.disabled,
    required this.track,
    required this.trackActive,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color primary;
  final Color primaryTint;
  final Color onPrimary;
  final Color accent;
  final Color highlight;
  final Color textPrimary;
  final Color textSecondary;
  final Color surface;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color background;
  final Color surfaceMuted;
  final Color authGradientTop;
  final Color authGradientBottom;
  final Color homeHeader;
  final Color banner;
  final Color success;
  final Color progressSecondary;
  final Color disabled;
  final Color track;
  final Color trackActive;
  final Color shimmerBase;
  final Color shimmerHighlight;

  static const light = AppThemeColors(
    primary: AppColors.cyan,
    primaryTint: AppColors.cyanTint,
    onPrimary: AppColors.white,
    accent: AppColors.pink,
    highlight: AppColors.orange,
    textPrimary: AppColors.ink,
    textSecondary: AppColors.slate,
    surface: AppColors.white,
    inverseSurface: AppColors.ink,
    onInverseSurface: AppColors.white,
    background: AppColors.cloud,
    surfaceMuted: AppColors.mist,
    authGradientTop: AppColors.blush,
    authGradientBottom: AppColors.white,
    homeHeader: AppColors.peach,
    banner: AppColors.purple,
    success: AppColors.green,
    progressSecondary: AppColors.skyBlue,
    disabled: AppColors.silver,
    track: AppColors.cloud,
    trackActive: AppColors.grey,
    shimmerBase: AppColors.smoke,
    shimmerHighlight: AppColors.mist,
  );

  @override
  AppThemeColors copyWith({
    Color? primary,
    Color? primaryTint,
    Color? onPrimary,
    Color? accent,
    Color? highlight,
    Color? textPrimary,
    Color? textSecondary,
    Color? surface,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? background,
    Color? surfaceMuted,
    Color? authGradientTop,
    Color? authGradientBottom,
    Color? homeHeader,
    Color? banner,
    Color? success,
    Color? progressSecondary,
    Color? disabled,
    Color? track,
    Color? trackActive,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) => AppThemeColors(
    primary: primary ?? this.primary,
    primaryTint: primaryTint ?? this.primaryTint,
    onPrimary: onPrimary ?? this.onPrimary,
    accent: accent ?? this.accent,
    highlight: highlight ?? this.highlight,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    surface: surface ?? this.surface,
    inverseSurface: inverseSurface ?? this.inverseSurface,
    onInverseSurface: onInverseSurface ?? this.onInverseSurface,
    background: background ?? this.background,
    surfaceMuted: surfaceMuted ?? this.surfaceMuted,
    authGradientTop: authGradientTop ?? this.authGradientTop,
    authGradientBottom: authGradientBottom ?? this.authGradientBottom,
    homeHeader: homeHeader ?? this.homeHeader,
    banner: banner ?? this.banner,
    success: success ?? this.success,
    progressSecondary: progressSecondary ?? this.progressSecondary,
    disabled: disabled ?? this.disabled,
    track: track ?? this.track,
    trackActive: trackActive ?? this.trackActive,
    shimmerBase: shimmerBase ?? this.shimmerBase,
    shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
  );

  @override
  AppThemeColors lerp(AppThemeColors? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppThemeColors(
      primary: mix(primary, other.primary),
      primaryTint: mix(primaryTint, other.primaryTint),
      onPrimary: mix(onPrimary, other.onPrimary),
      accent: mix(accent, other.accent),
      highlight: mix(highlight, other.highlight),
      textPrimary: mix(textPrimary, other.textPrimary),
      textSecondary: mix(textSecondary, other.textSecondary),
      surface: mix(surface, other.surface),
      inverseSurface: mix(inverseSurface, other.inverseSurface),
      onInverseSurface: mix(onInverseSurface, other.onInverseSurface),
      background: mix(background, other.background),
      surfaceMuted: mix(surfaceMuted, other.surfaceMuted),
      authGradientTop: mix(authGradientTop, other.authGradientTop),
      authGradientBottom: mix(authGradientBottom, other.authGradientBottom),
      homeHeader: mix(homeHeader, other.homeHeader),
      banner: mix(banner, other.banner),
      success: mix(success, other.success),
      progressSecondary: mix(progressSecondary, other.progressSecondary),
      disabled: mix(disabled, other.disabled),
      track: mix(track, other.track),
      trackActive: mix(trackActive, other.trackActive),
      shimmerBase: mix(shimmerBase, other.shimmerBase),
      shimmerHighlight: mix(shimmerHighlight, other.shimmerHighlight),
    );
  }
}

extension AppThemeColorsX on BuildContext {
  AppThemeColors get appColors => Theme.of(this).extension<AppThemeColors>()!;
}
