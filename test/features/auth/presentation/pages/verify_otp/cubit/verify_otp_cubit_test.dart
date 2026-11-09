import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/auth_rules.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/entity/otp_result.dart';
import 'package:j_donuts/features/auth/domain/entity/user_entity.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:j_donuts/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:j_donuts/features/auth/presentation/pages/verify_otp/cubit/verify_otp_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockVerifyOtp extends Mock implements VerifyOtpUseCase {}

class _MockRequestOtp extends Mock implements RequestOtpUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

const _phone = '+959254135592';
const _rightCode = '123456';
const _wrongCode = '654321';
const _second = Duration(seconds: 1);

// Timers run in testWidgets' fake time, so the 5:00 countdown is pumped
// instead of waited for.
void main() {
  late _MockVerifyOtp verifyOtp;
  late _MockRequestOtp requestOtp;
  late _MockSnackShower snack;

  setUpAll(() {
    registerFallbackValue(const VerifyOtpParam(phone: '', code: ''));
    registerFallbackValue(
      const RequestOtpParam(phone: '', flow: AuthFlow.register),
    );
    registerFallbackValue(const CacheFailure());
  });

  setUp(() {
    verifyOtp = _MockVerifyOtp();
    requestOtp = _MockRequestOtp();
    snack = _MockSnackShower();
    when(
      () => verifyOtp(
        any(
          that: isA<VerifyOtpParam>().having((p) => p.code, 'code', _wrongCode),
        ),
      ),
    ).thenAnswer((_) async => const Failed(InvalidOtpFailure()));
  });

  VerifyOtpCubit build() =>
      VerifyOtpCubit(verifyOtp, requestOtp, snack)
        ..start(phone: _phone, flow: AuthFlow.register);

  void whenRightCode(OtpResult result) => when(
    () => verifyOtp(
      any(
        that: isA<VerifyOtpParam>().having((p) => p.code, 'code', _rightCode),
      ),
    ),
  ).thenAnswer((_) async => Success(result));

  Future<void> enter(WidgetTester tester, VerifyOtpCubit cubit, String code) {
    cubit.codeChanged(code);
    return tester.pump();
  }

  // Closes the cubit inside the test, so its countdown timer never outlives it.
  void otpTest(
    String description,
    Future<void> Function(WidgetTester tester, VerifyOtpCubit cubit) body,
  ) => testWidgets(description, (tester) async {
    final cubit = build();
    await body(tester, cubit);
    await cubit.close();
  });

  group('VerifyOtpCubit', () {
    otpTest('waits for all six digits before verifying', (tester, cubit) async {
      await enter(tester, cubit, '12345');

      verifyNever(() => verifyOtp(any()));
    });

    otpTest('opens the Name step for a new number', (tester, cubit) async {
      whenRightCode(const OtpNeedsRegistration());

      await enter(tester, cubit, _rightCode);

      expect(cubit.state.result, isA<OtpNeedsRegistration>());
      expect(cubit.state.canType, isFalse);
    });

    otpTest('signs a known member in', (tester, cubit) async {
      final user = UserEntity(
        id: '1',
        phone: _phone,
        firstName: 'Hania',
        dateOfBirth: DateTime(1990),
      );
      whenRightCode(OtpSignedIn(user));

      await enter(tester, cubit, _rightCode);

      expect(cubit.state.result, isA<OtpSignedIn>());
    });

    otpTest('clears and shakes the boxes after a wrong code', (
      tester,
      cubit,
    ) async {
      cubit.codeController.text = _wrongCode;

      await enter(tester, cubit, _wrongCode);

      expect(cubit.codeController.text, isEmpty);
      expect(cubit.state.showWrongCode, isTrue);
      expect(cubit.state.shakeCount, 1);
      expect(cubit.state.attemptsLeft, AuthRules.maxOtpAttempts - 1);
    });

    otpTest('hides the wrong-code message when the user types again', (
      tester,
      cubit,
    ) async {
      await enter(tester, cubit, _wrongCode);

      await enter(tester, cubit, '1');

      expect(cubit.state.showWrongCode, isFalse);
    });

    otpTest('locks after three wrong codes and opens Resend at once', (
      tester,
      cubit,
    ) async {
      for (var i = 0; i < AuthRules.maxOtpAttempts; i++) {
        await enter(tester, cubit, _wrongCode);
      }

      expect(cubit.state.isLocked, isTrue);
      expect(cubit.state.canType, isFalse);
      expect(cubit.state.canResend, isTrue);
      await enter(tester, cubit, _wrongCode);
      verify(() => verifyOtp(any())).called(AuthRules.maxOtpAttempts);
    });

    otpTest('counts Resend down from 5:00 and opens it at zero', (
      tester,
      cubit,
    ) async {
      await tester.pump(_second);
      expect(cubit.state.resendIn, AuthRules.resendCountdown - _second);
      expect(cubit.state.canResend, isFalse);

      await tester.pump(AuthRules.resendCountdown);
      expect(cubit.state.resendIn, Duration.zero);
      expect(cubit.state.canResend, isTrue);
    });

    otpTest('ignores Resend while the countdown is running', (
      tester,
      cubit,
    ) async {
      await cubit.resend();

      verifyNever(() => requestOtp(any()));
    });

    otpTest('Resend unlocks the code and restarts the countdown', (
      tester,
      cubit,
    ) async {
      when(() => requestOtp(any()))
          .thenAnswer((_) async => const Success(null));
      for (var i = 0; i < AuthRules.maxOtpAttempts; i++) {
        await enter(tester, cubit, _wrongCode);
      }

      await cubit.resend();
      await tester.pump();

      expect(cubit.state.isLocked, isFalse);
      expect(cubit.state.showWrongCode, isFalse);
      expect(cubit.state.resendIn, AuthRules.resendCountdown);
      verify(() => snack.info(any())).called(1);
    });

    otpTest('reports a failed verification other than a wrong code', (
      tester,
      cubit,
    ) async {
      when(
        () => verifyOtp(any()),
      ).thenAnswer((_) async => const Failed(ConnectionFailure()));

      await enter(tester, cubit, _rightCode);

      expect(cubit.state.wrongAttempts, 0);
      expect(cubit.state.isVerifying, isFalse);
      verify(() => snack.error(any(that: isA<ConnectionFailure>()))).called(1);
    });
  });
}
