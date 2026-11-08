import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/components/input/app_text_field.dart';
import 'package:j_donuts/shared/styles/styles.dart';

import '../../../helpers/test_app.dart';

const _colors = AppThemeColors.light;

Widget _field(
  TextEditingController controller, {
  String? errorText,
  VoidCallback? onFocusLost,
  ValueChanged<String>? onChanged,
}) => Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        AppTextField(
          controller: controller,
          hintText: 'First Name',
          prefixText: '+95 ',
          errorText: errorText,
          onFocusLost: onFocusLost,
          onChanged: onChanged,
        ),
        const TextField(key: Key('other')),
      ],
    ),
  ),
);

Color? _borderColor(WidgetTester tester) {
  final box = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
  return ((box.decoration! as BoxDecoration).border! as Border).top.color;
}

void main() {
  late TextEditingController controller;

  setUp(() => controller = TextEditingController());
  tearDown(() => controller.dispose());

  group('AppTextField', () {
    testWidgets('shows the hint and reports typed text', (tester) async {
      String? typed;
      await tester.pumpWidget(
        testApp(_field(controller, onChanged: (text) => typed = text)),
      );

      expect(find.text('First Name'), findsOneWidget);
      await tester.enterText(find.byType(AppTextField), 'Ye Min');

      expect(typed, 'Ye Min');
      expect(controller.text, 'Ye Min');
    });

    testWidgets('shows the prefix once the field has focus', (tester) async {
      await tester.pumpWidget(testApp(_field(controller)));

      await tester.tap(find.byType(AppTextField));
      await tester.pumpAndSettle();

      expect(find.text('+95 '), findsOneWidget);
    });

    testWidgets('turns the border cyan on focus', (tester) async {
      await tester.pumpWidget(testApp(_field(controller)));
      expect(_borderColor(tester), _colors.surface);

      await tester.tap(find.byType(AppTextField));
      await tester.pumpAndSettle();

      expect(_borderColor(tester), _colors.primary);
    });

    testWidgets('shows the error under the field with a pink border', (
      tester,
    ) async {
      await tester.pumpWidget(testApp(_field(controller)));
      final closedHeight = tester.getSize(find.byType(AppTextField)).height;

      await tester.pumpWidget(
        testApp(_field(controller, errorText: 'Enter your first name')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Enter your first name'), findsOneWidget);
      expect(_borderColor(tester), _colors.accent);
      expect(
        tester.getSize(find.byType(AppTextField)).height,
        greaterThan(closedHeight),
      );
    });

    testWidgets('reports when the user leaves the field', (tester) async {
      var focusLost = 0;
      await tester.pumpWidget(
        testApp(_field(controller, onFocusLost: () => focusLost++)),
      );

      await tester.tap(find.byType(AppTextField));
      await tester.pump();
      expect(focusLost, 0);

      await tester.tap(find.byKey(const Key('other')));
      await tester.pump();
      expect(focusLost, 1);
    });
  });
}
