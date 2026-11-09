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
    required this.successStrong,
    required this.progressSecondary,
    required this.disabled,
    required this.track,
    required this.trackActive,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.scrim,
    required this.headerBadge,
    required this.headerBadgeIcon,
    required this.landscapeCloud,
    required this.tierSilver,
    required this.tierGold,
    required this.tierPlatinum,
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

  /// Dark enough for white text (back-online banner).
  final Color successStrong;
  final Color progressSecondary;
  final Color disabled;
  final Color track;
  final Color trackActive;
  final Color shimmerBase;
  final Color shimmerHighlight;

  /// Behind dialogs.
  final Color scrim;

  /// Tier badge shape behind the Home header, and its star.
  final Color headerBadge;
  final Color headerBadgeIcon;

  /// Clouds behind the nearby shops.
  final Color landscapeCloud;

  /// Tier shields on the Rewards ladder.
  final Color tierSilver;
  final Color tierGold;
  final Color tierPlatinum;

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
    successStrong: AppColors.forest,
    progressSecondary: AppColors.skyBlue,
    disabled: AppColors.silver,
    track: AppColors.cloud,
    trackActive: AppColors.grey,
    shimmerBase: AppColors.smoke,
    shimmerHighlight: AppColors.mist,
    scrim: AppColors.scrim,
    headerBadge: AppColors.apricot,
    headerBadgeIcon: AppColors.taupe,
    landscapeCloud: AppColors.cream,
    tierSilver: AppColors.pewter,
    tierGold: AppColors.honey,
    tierPlatinum: AppColors.ice,
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
    Color? successStrong,
    Color? progressSecondary,
    Color? disabled,
    Color? track,
    Color? trackActive,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? scrim,
    Color? headerBadge,
    Color? headerBadgeIcon,
    Color? landscapeCloud,
    Color? tierSilver,
    Color? tierGold,
    Color? tierPlatinum,
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
    successStrong: successStrong ?? this.successStrong,
    progressSecondary: progressSecondary ?? this.progressSecondary,
    disabled: disabled ?? this.disabled,
    track: track ?? this.track,
    trackActive: trackActive ?? this.trackActive,
    shimmerBase: shimmerBase ?? this.shimmerBase,
    shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    scrim: scrim ?? this.scrim,
    headerBadge: headerBadge ?? this.headerBadge,
    headerBadgeIcon: headerBadgeIcon ?? this.headerBadgeIcon,
    landscapeCloud: landscapeCloud ?? this.landscapeCloud,
    tierSilver: tierSilver ?? this.tierSilver,
    tierGold: tierGold ?? this.tierGold,
    tierPlatinum: tierPlatinum ?? this.tierPlatinum,
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
      successStrong: mix(successStrong, other.successStrong),
      progressSecondary: mix(progressSecondary, other.progressSecondary),
      disabled: mix(disabled, other.disabled),
      track: mix(track, other.track),
      trackActive: mix(trackActive, other.trackActive),
      shimmerBase: mix(shimmerBase, other.shimmerBase),
      shimmerHighlight: mix(shimmerHighlight, other.shimmerHighlight),
      scrim: mix(scrim, other.scrim),
      headerBadge: mix(headerBadge, other.headerBadge),
      headerBadgeIcon: mix(headerBadgeIcon, other.headerBadgeIcon),
      landscapeCloud: mix(landscapeCloud, other.landscapeCloud),
      tierSilver: mix(tierSilver, other.tierSilver),
      tierGold: mix(tierGold, other.tierGold),
      tierPlatinum: mix(tierPlatinum, other.tierPlatinum),
    );
  }
}

extension AppThemeColorsX on BuildContext {
  AppThemeColors get appColors => Theme.of(this).extension<AppThemeColors>()!;
}
