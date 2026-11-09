import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/components/components.dart';

import '../../../../helpers/test_app.dart';

/// Pumps an auth step [page] with the given [cubit], as its route would.
Future<void> pumpAuthPage<C extends StateStreamableSource<Object?>>(
  WidgetTester tester,
  C cubit,
  Widget page,
) async {
  await tester.pumpWidget(
    testApp(BlocProvider<C>.value(value: cubit, child: page)),
  );
  await tester.pump();
}

/// Types into the [index]th field and leaves it, as a user moving on would.
Future<void> typeAndLeave(
  WidgetTester tester,
  String text, {
  int index = 0,
}) async {
  await tester.enterText(find.byType(TextField).at(index), text);
  await tester.pump();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
}

/// Whether the Continue button (labelled [label]) can be tapped.
bool isEnabled(WidgetTester tester, String label) =>
    tester
        .widget<AppButton>(
          find.byWidgetPredicate((w) => w is AppButton && w.label == label),
        )
        .onPressed !=
    null;
