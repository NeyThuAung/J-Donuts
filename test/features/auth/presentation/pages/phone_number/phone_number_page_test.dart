import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/cubit/phone_number_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/phone_number/phone_number_page.dart';
import 'package:j_donuts/l10n/gen/app_localizations_en.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_page_harness.dart';

class _MockRequestOtp extends Mock implements RequestOtpUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

final _l10n = AppLocalizationsEn();

void main() {
  late _MockRequestOtp requestOtp;
  late PhoneNumberCubit cubit;

  setUpAll(() {
    registerFallbackValue(
      const RequestOtpParam(phone: '', flow: AuthFlow.register),
    );
  });

  setUp(() => requestOtp = _MockRequestOtp());
  tearDown(() => cubit.close());

  Future<void> pump(WidgetTester tester, AuthFlow flow) {
    cubit = PhoneNumberCubit(requestOtp, _MockSnackShower())..start(flow);
    return pumpAuthPage(tester, cubit, const PhoneNumberPage());
  }

  group('PhoneNumberPage validation', () {
    testWidgets('keeps Continue disabled while the field is empty', (
      tester,
    ) async {
      await pump(tester, AuthFlow.register);

      expect(isEnabled(tester, _l10n.commonContinue), isFalse);
      expect(find.text(_l10n.authPhoneErrorEmpty), findsNothing);
    });

    testWidgets('says the number is too short after leaving the field', (
      tester,
    ) async {
      await pump(tester, AuthFlow.register);

      await typeAndLeave(tester, '0925413');

      expect(find.text(_l10n.authPhoneErrorTooShort), findsOneWidget);
      expect(isEnabled(tester, _l10n.commonContinue), isFalse);
    });

    testWidgets('says Myanmar numbers start with 09', (tester) async {
      await pump(tester, AuthFlow.register);

      await typeAndLeave(tester, '08254135592');

      expect(find.text(_l10n.authPhoneErrorWrongLeadingDigit), findsOneWidget);
    });

    testWidgets('drops letters as they are typed', (tester) async {
      await pump(tester, AuthFlow.register);

      await typeAndLeave(tester, '09abc');

      expect(cubit.phoneController.text, '09');
      expect(find.text(_l10n.authPhoneErrorTooShort), findsOneWidget);
    });

    testWidgets('enables Continue for a valid number with spaces', (
      tester,
    ) async {
      await pump(tester, AuthFlow.register);

      await typeAndLeave(tester, '09 254 135 592');

      expect(isEnabled(tester, _l10n.commonContinue), isTrue);
      expect(find.text(_l10n.authPhoneErrorTooShort), findsNothing);
    });

    testWidgets(
      'offers to register when logging in with an unregistered number',
      (tester) async {
        when(
          () => requestOtp(any()),
        ).thenAnswer((_) async => const Failed(PhoneNotRegisteredFailure()));
        await pump(tester, AuthFlow.logIn);
        await typeAndLeave(tester, '09254135592');

        await tester.tap(find.text(_l10n.commonContinue.toUpperCase()));
        await tester.pumpAndSettle();

        expect(find.text(_l10n.authPhoneNotRegistered), findsOneWidget);
        expect(find.text(_l10n.authPhoneRegisterInstead), findsOneWidget);
      },
    );
  });
}
