import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/auth_rules.dart';
import 'package:j_donuts/features/auth/presentation/pages/name/cubit/name_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/name/name_page.dart';
import 'package:j_donuts/l10n/gen/app_localizations_en.dart';

import '../auth_page_harness.dart';

final _l10n = AppLocalizationsEn();
const _lastName = 1;

void main() {
  late NameCubit cubit;

  setUp(() => cubit = NameCubit());
  tearDown(() => cubit.close());

  Future<void> pump(WidgetTester tester) => pumpAuthPage(
    tester,
    cubit,
    const NamePage(phone: '+959254135592'),
  );

  group('NamePage validation', () {
    testWidgets('asks for a first name after leaving it empty', (tester) async {
      await pump(tester);

      await typeAndLeave(tester, '');

      expect(find.text(_l10n.authNameErrorEmpty), findsOneWidget);
      expect(isEnabled(tester, _l10n.commonContinue), isFalse);
    });

    testWidgets('rejects numbers in the first name', (tester) async {
      await pump(tester);

      await typeAndLeave(tester, 'Hania7');

      expect(find.text(_l10n.authNameErrorDigits), findsOneWidget);
    });

    testWidgets('rejects a first name longer than 50 characters', (
      tester,
    ) async {
      await pump(tester);

      await typeAndLeave(
        tester,
        'a' * (AuthRules.nameMaxLength + 1),
      );

      expect(
        find.text(_l10n.authNameErrorTooLong(AuthRules.nameMaxLength)),
        findsOneWidget,
      );
    });

    testWidgets('rejects symbols in the optional last name', (tester) async {
      await pump(tester);
      await typeAndLeave(tester, 'Hania');

      await typeAndLeave(tester, 'Aung!', index: _lastName);

      expect(find.text(_l10n.authNameErrorInvalid), findsOneWidget);
      expect(isEnabled(tester, _l10n.commonContinue), isFalse);
    });

    testWidgets('enables Continue with only a first name', (tester) async {
      await pump(tester);

      await typeAndLeave(tester, 'Hania');

      expect(isEnabled(tester, _l10n.commonContinue), isTrue);
    });
  });
}
