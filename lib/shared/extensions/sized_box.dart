import 'package:flutter/widgets.dart';

extension SizedBoxX on num {
  SizedBox get toWidthSizedBox => SizedBox(width: toDouble());
  SizedBox get toHeightSizedBox => SizedBox(height: toDouble());
}
