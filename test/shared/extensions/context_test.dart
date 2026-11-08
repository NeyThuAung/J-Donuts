import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/extensions/context.dart';
import 'package:j_donuts/shared/styles/styles.dart';

void main() {
  group('BuildContextX', () {
    testWidgets('exposes the app theme and its text theme', (tester) async {
      final theme = AppTheme.light(const Locale('en'));
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(context.theme.colorScheme.primary, theme.colorScheme.primary);
      expect(
        context.textTheme.titleMedium?.fontFamily,
        theme.textTheme.titleMedium?.fontFamily,
      );
    });
  });
}
