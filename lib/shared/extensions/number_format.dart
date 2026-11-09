import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension NumberFormatX on int {
  /// Thousands separators in the app language: 3,200 / ၃,၂၀၀.
  String grouped(BuildContext context) => NumberFormat.decimalPattern(
    Localizations.localeOf(context).toLanguageTag(),
  ).format(this);
}
