import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/shared/styles/styles.dart';

const smallestPhone = Size(320, 568);
const maxTextScale = 1.3;

/// Themed, localized app around [child] for widget tests.
Widget testApp(
  Widget child, {
  Locale locale = const Locale('en'),
  bool reduceMotion = false,
  double textScale = 1,
}) => MaterialApp(
  locale: locale,
  theme: AppTheme.light(locale),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: (context, app) => MediaQuery(
    data: MediaQuery.of(context).copyWith(
      disableAnimations: reduceMotion,
      textScaler: TextScaler.linear(textScale),
    ),
    child: app!,
  ),
  home: child,
);

/// Sets a phone-sized test surface for the rest of the test.
void useScreenSize(WidgetTester tester, Size size) {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}
