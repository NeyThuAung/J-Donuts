import 'package:flutter/painting.dart';

import 'app_colors.dart';

class AppInsets {
  const AppInsets(this._scale);

  final double _scale;

  double get xxs => 4 * _scale;
  double get xs => 8 * _scale;
  double get sm => 12 * _scale;
  double get md => 16 * _scale;
  double get lg => 24 * _scale;
  double get xl => 32 * _scale;
  double get xxl => 48 * _scale;
}

class AppCorners {
  const AppCorners();

  final double xs = 4;
  final double sm = 8;
  final double md = 16;
  final double lg = 24;
}

class AppSizes {
  const AppSizes();

  final double buttonHeight = 52;
  final double iconButton = 40;
  final double minTapTarget = 44;
  final double icon = 24;
  final double iconLg = 32;
  final double iconSm = 16;
  final double avatar = 48;
  final double errorBadge = 64;
  final double navBarHeight = 72;
  final double spinner = 22;
  final double spinnerStroke = 2.5;
  final double stepRing = 32;
  final double stepRingStroke = 5;
  final double focusBorder = 1.5;
}

class AppGrid {
  const AppGrid();

  final double pageMargin = 24;
  final double authPageMargin = 32;
  final double cardGap = 16;
}

class AppShadows {
  const AppShadows();

  final List<BoxShadow> card = const [
    BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 4)),
  ];

  final List<BoxShadow> soft = const [
    BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: Offset(0, 2)),
  ];
}
