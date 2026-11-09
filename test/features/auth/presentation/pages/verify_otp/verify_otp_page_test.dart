import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/auth_rules.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:j_donuts/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:j_donuts/features/auth/presentation/pages/verify_otp/cubit/verify_otp_cubit.dart';
import 'package:j_donuts/features/auth/presentation/pages/verify_otp/verify_otp_page.dart';
import 'package:j_donuts/l10n/gen/app_localizations_en.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_page_harness.dart';

class _MockVerifyOtp extends Mock implements VerifyOtpUseCase {}

class _MockRequestOtp extends Mock implements RequestOtpUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

final _l10n = AppLocalizationsEn();
const _phone = '+959254135592';
const _wrongCode = '654321';

void main() {
  late _MockVerifyOtp verifyOtp;

  setUpAll(
    () => registerFallbackValue(const VerifyOtpParam(phone: '', code: '')),
  );

  setUp(() {
    verifyOtp = _MockVerifyOtp();
    when(
      () => verifyOtp(any()),
    ).thenAnswer((_) async => const Failed(InvalidOtpFailure()));
  });

  // The cubit's countdown timer must stop before the test ends.
  void otpPageTest(
    String description,
    Future<void> Function(WidgetTester tester) body,
  ) => testWidgets(description, (tester) async {
    final cubit = VerifyOtpCubit(
      verifyOtp,
      _MockRequestOtp(),
      _MockSnackShower(),
    )..start(phone: _phone, flow: AuthFlow.register);
    await pumpAuthPage(tester, cubit, const VerifyOtpPage(phone: _phone));
    await body(tester);
    await tester.pumpWidget(const SizedBox());
    await cubit.close();
  });

  Future<void> enterCode(WidgetTester tester, String code) async {
    await tester.enterText(find.byType(TextField), code);
    await tester.pump();
    await tester.pump(AuthRules.resendCountdown ~/ 1000);
  }

  group('VerifyOtpPage validation', () {
    otpPageTest('says how many tries are left after a wrong code', (
      tester,
    ) async {
      await enterCode(tester, _wrongCode);

      expect(
        find.text(_l10n.authOtpWrongCode(AuthRules.maxOtpAttempts - 1)),
        findsOneWidget,
      );
    });

    otpPageTest('locks the code after three wrong tries', (tester) async {
      for (var i = 0; i < AuthRules.maxOtpAttempts; i++) {
        await enterCode(tester, _wrongCode);
      }

      expect(find.text(_l10n.authOtpLocked), findsOneWidget);
      expect(find.text(_l10n.authOtpResend), findsOneWidget);
    });

    otpPageTest('shows the Resend countdown instead of the link at first', (
      tester,
    ) async {
      expect(find.text(_l10n.authOtpResend), findsNothing);
      expect(find.text(_l10n.authOtpNoCode), findsOneWidget);
    });

    otpPageTest('does not verify until all six digits are in', (
      tester,
    ) async {
      await enterCode(tester, '12345');

      verifyNever(() => verifyOtp(any()));
      expect(find.textContaining('tries left'), findsNothing);
    });
  });
}
