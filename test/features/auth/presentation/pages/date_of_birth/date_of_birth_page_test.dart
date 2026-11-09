import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/auth_rules.dart';
import 'package:j_donuts/features/auth/domain/usecase/register_usecase.dart';
import 'package:j_donuts/features/auth/presentation/pages/date_of_birth/cubit/date_of_birth_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/date_of_birth/date_of_birth_page.dart';
import 'package:j_donuts/l10n/gen/app_localizations_en.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_page_harness.dart';

class _MockRegister extends Mock implements RegisterUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

final _l10n = AppLocalizationsEn();

// The wheels write straight into the cubit; these tests pick through it and
// check what the page shows.
void main() {
  late DateOfBirthCubit cubit;

  setUp(
    () =>
        cubit = DateOfBirthCubit(_MockRegister(), _MockSnackShower())
          ..start(phone: '+959254135592', firstName: 'Hania'),
  );
  tearDown(() => cubit.close());

  Future<void> pickAndPump(WidgetTester tester, int year, int month, int day) {
    cubit
      ..yearPicked(year)
      ..monthPicked(month)
      ..dayPicked(day);
    return tester.pumpAndSettle();
  }

  group('DateOfBirthPage validation', () {
    testWidgets('keeps Continue disabled until a date is picked', (
      tester,
    ) async {
      await pumpAuthPage(tester, cubit, const DateOfBirthPage());

      expect(isEnabled(tester, _l10n.commonContinue), isFalse);
    });

    testWidgets('says members must be at least 13', (tester) async {
      await pumpAuthPage(tester, cubit, const DateOfBirthPage());

      await pickAndPump(tester, DateTime.now().year - 5, 1, 1);

      expect(
        find.text(_l10n.authDobErrorTooYoung(AuthRules.minimumAge)),
        findsOneWidget,
      );
      expect(isEnabled(tester, _l10n.commonContinue), isFalse);
    });

    testWidgets('says 31 April does not exist', (tester) async {
      await pumpAuthPage(tester, cubit, const DateOfBirthPage());

      await pickAndPump(tester, 1990, 4, 31);

      expect(find.text(_l10n.authDobErrorInvalid), findsOneWidget);
    });

    testWidgets('enables Continue for a valid adult date', (tester) async {
      await pumpAuthPage(tester, cubit, const DateOfBirthPage());

      await pickAndPump(tester, 1990, 6, 15);

      expect(isEnabled(tester, _l10n.commonContinue), isTrue);
      expect(find.text(_l10n.authDobErrorInvalid), findsNothing);
    });

    testWidgets('fills the fields when the wheels open', (tester) async {
      await pumpAuthPage(tester, cubit, const DateOfBirthPage());

      await tester.tap(find.text(_l10n.authDobYear));
      await tester.pumpAndSettle();

      expect(cubit.state.hasDate, isTrue);
      expect(isEnabled(tester, _l10n.commonDone), isTrue);
    });
  });
}
