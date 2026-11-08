import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension SystemOverlayX on BuildContext {
  // Transparent bars with icons that contrast with the current theme.
  SystemUiOverlayStyle get systemOverlayStyle {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    final iconBrightness = isDark ? Brightness.light : Brightness.dark;

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: iconBrightness,
      // iOS describes the bar background, so it is the opposite of the icons.
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarIconBrightness: iconBrightness,
    );
  }
}
