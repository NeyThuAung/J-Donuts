import 'package:flutter/painting.dart';

import 'app_dimensions.dart';

enum ScreenType {
  sm(1),
  md(1.1),
  lg(1.2);

  const ScreenType(this.scale);

  final double scale;

  static const double _tabletLg = 800;
  static const double _tabletXl = 1000;

  static ScreenType fromSize(Size? size) {
    final shortestSide = size?.shortestSide ?? 0;
    if (shortestSide > _tabletXl) return lg;
    if (shortestSide > _tabletLg) return md;
    return sm;
  }
}

AppStyles $styles = AppStyles();

// App calls this on every build; styles rebuild only when the type changes.
void updateStylesForScreen(Size size) {
  final type = ScreenType.fromSize(size);
  if ($styles.screenType == type) return;
  $styles = AppStyles(screenType: type);
}

class AppStyles {
  AppStyles({this.screenType = ScreenType.sm});

  final ScreenType screenType;

  double get scale => screenType.scale;

  late final AppInsets insets = AppInsets(scale);
  final AppCorners corner = const AppCorners();
  final AppSizes size = const AppSizes();
  final AppGrid grid = const AppGrid();
  final AppShadows shadow = const AppShadows();
}
