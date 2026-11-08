import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/components/wrapper/dismiss_focus_wrapper.dart';

const _emptyAreaKey = Key('empty-area');

Widget _app(FocusNode focusNode, {VoidCallback? onButtonPressed}) =>
    MaterialApp(
      home: Scaffold(
        body: DismissFocusWrapper(
          child: Column(
            children: [
              TextField(focusNode: focusNode),
              TextButton(
                onPressed: onButtonPressed ?? () {},
                child: const Text('Tap me'),
              ),
              const Expanded(child: SizedBox(key: _emptyAreaKey)),
            ],
          ),
        ),
      ),
    );

void main() {
  group('DismissFocusWrapper', () {
    late FocusNode focusNode;

    setUp(() => focusNode = FocusNode());
    tearDown(() => focusNode.dispose());

    testWidgets('removes focus from a field when an empty area is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(_app(focusNode));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      await tester.tap(find.byKey(_emptyAreaKey));
      await tester.pump();

      expect(focusNode.hasFocus, isFalse);
    });

    testWidgets('keeps focus when the field itself is tapped', (tester) async {
      await tester.pumpWidget(_app(focusNode));
      await tester.tap(find.byType(TextField));
      await tester.pump();

      await tester.tap(find.byType(TextField));
      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('still lets buttons inside it receive taps', (tester) async {
      var presses = 0;
      await tester.pumpWidget(
        _app(focusNode, onButtonPressed: () => presses++),
      );

      await tester.tap(find.text('Tap me'));

      expect(presses, 1);
    });
  });
}
