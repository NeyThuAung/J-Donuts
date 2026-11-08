import 'package:flutter/painting.dart';

import 'app_colors.dart';

class AppInsets {
  const AppInsets();

  final double xxs = 4;
  final double xs = 8;
  final double sm = 12;
  final double md = 16;
  final double lg = 24;
  final double xl = 32;
  final double xxl = 48;
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
  final double iconSm = 16;
  final double avatar = 48;
  final double navBarHeight = 72;
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
