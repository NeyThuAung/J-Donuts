import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// Full month name in the app's language: May, မေ.
String monthName(BuildContext context, int month) => DateFormat.MMMM(
  Localizations.localeOf(context).toLanguageTag(),
).format(DateTime(DateTime.now().year, month));
