part of 'verify_otp_cubit.dart';

@freezed
abstract class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState({
    @Default('') String phone,
    @Default(AuthFlow.register) AuthFlow flow,
    @Default(AuthRules.resendCountdown) Duration resendIn,
    @Default(0) int wrongAttempts,
    @Default(false) bool showWrongCode,
    @Default(0) int shakeCount,
    @Default(false) bool isVerifying,
    @Default(false) bool isResending,
    OtpResult? result,
  }) = _VerifyOtpState;

  const VerifyOtpState._();

  bool get isLocked => wrongAttempts >= AuthRules.maxOtpAttempts;

  int get attemptsLeft => AuthRules.maxOtpAttempts - wrongAttempts;

  bool get canResend => resendIn == Duration.zero && !isResending;

  bool get canType => !isLocked && !isVerifying && result == null;
}
