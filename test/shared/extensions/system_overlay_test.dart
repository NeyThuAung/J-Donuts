import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/extensions/system_overlay.dart';
import 'package:j_donuts/shared/styles/styles.dart';

Future<SystemUiOverlayStyle> _styleFor(
  WidgetTester tester,
  ThemeData theme,
) async {
  late SystemUiOverlayStyle style;
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Builder(
        builder: (context) {
          style = context.systemOverlayStyle;
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return style;
}

void main() {
  group('SystemOverlayX', () {
    testWidgets('uses dark icons on transparent bars in the light theme', (
      tester,
    ) async {
      final style = await _styleFor(tester, AppTheme.light(const Locale('en')));

      expect(style.statusBarColor, Colors.transparent);
      expect(style.systemNavigationBarColor, Colors.transparent);
      expect(style.statusBarIconBrightness, Brightness.dark);
      expect(style.statusBarBrightness, Brightness.light);
      expect(style.systemNavigationBarIconBrightness, Brightness.dark);
    });

    testWidgets('uses light icons in a dark theme', (tester) async {
      final style = await _styleFor(tester, ThemeData.dark());

      expect(style.statusBarIconBrightness, Brightness.light);
      expect(style.statusBarBrightness, Brightness.dark);
    });
  });
}
