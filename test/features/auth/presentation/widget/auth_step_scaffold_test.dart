import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/presentation/widget/auth_step.dart';
import 'package:j_donuts/features/auth/presentation/widget/auth_step_scaffold.dart';
import 'package:j_donuts/features/auth/presentation/widget/step_progress_ring.dart';
import 'package:j_donuts/shared/components/components.dart';

import '../../../../helpers/test_app.dart';

const _longTitle = 'What’s your date of birth?';

final _first = TextEditingController();
final _last = TextEditingController();

Widget _scaffold({VoidCallback? onTerms, VoidCallback? onPrivacy}) =>
    AuthStepScaffold(
      step: AuthStep.name,
      title: _longTitle,
      subtitle: const Text('We’ve sent 6 digit OTP to +959254135592'),
      body: Column(
        children: [
          AppTextField(controller: _first, hintText: 'First Name'),
          const SizedBox(height: 16),
          AppTextField(
            controller: _last,
            hintText: 'Last Name',
            errorText: 'Use letters and spaces only',
          ),
        ],
      ),
      action: AppButton(label: 'Continue', onPressed: () {}),
      onTermsTap: onTerms ?? () {},
      onPrivacyTap: onPrivacy ?? () {},
    );

// Opens the scaffold as a second route so Back has somewhere to go.
Widget _withRouteBelow() => Builder(
  builder: (context) => Scaffold(
    body: TextButton(
      onPressed: () => Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => _scaffold())),
      child: const Text('open'),
    ),
  ),
);

void main() {
  tearDownAll(() {
    _first.dispose();
    _last.dispose();
  });

  group('AuthStepScaffold', () {
    testWidgets('shows the ring, title, fields, action and terms', (
      tester,
    ) async {
      await tester.pumpWidget(testApp(_scaffold()));
      await tester.pumpAndSettle();

      expect(find.byType(StepProgressRing), findsOneWidget);
      expect(find.text(_longTitle), findsOneWidget);
      expect(find.text('CONTINUE'), findsOneWidget);
      expect(find.text('Terms of Use'), findsOneWidget);
      expect(find.text('Privacy Policy'), findsOneWidget);
    });

    testWidgets('goes back to the previous step', (tester) async {
      await tester.pumpWidget(testApp(_withRouteBelow()));
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.byType(AuthStepScaffold), findsNothing);
      expect(find.text('open'), findsOneWidget);
    });

    testWidgets('opens Terms of Use and Privacy Policy from the footer', (
      tester,
    ) async {
      var terms = 0;
      var privacy = 0;
      await tester.pumpWidget(
        testApp(
          _scaffold(onTerms: () => terms++, onPrivacy: () => privacy++),
        ),
      );

      await tester.tap(find.text('Terms of Use'));
      await tester.tap(find.text('Privacy Policy'));

      expect(terms, 1);
      expect(privacy, 1);
    });

    testWidgets('keeps both links inside the Burmese sentence', (
      tester,
    ) async {
      await tester.pumpWidget(
        testApp(_scaffold(), locale: const Locale('my')),
      );

      expect(find.text('အသုံးပြုမှု စည်းမျဉ်းများ'), findsOneWidget);
      expect(find.text('ကိုယ်ရေးအချက်အလက် မူဝါဒ'), findsOneWidget);
    });

    for (final locale in const [Locale('en'), Locale('my')]) {
      testWidgets(
        'fits the smallest phone at text scale 1.3 in ${locale.languageCode}',
        (tester) async {
          useScreenSize(tester, smallestPhone);
          await tester.pumpWidget(
            testApp(_scaffold(), locale: locale, textScale: maxTextScale),
          );
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          await tester.ensureVisible(find.byType(AppButton));
          await tester.pumpAndSettle();
          expect(find.byType(AppButton).hitTestable(), findsOneWidget);
        },
      );
    }
  });
}
