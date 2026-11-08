part of 'phone_number_cubit.dart';

@freezed
abstract class PhoneNumberState with _$PhoneNumberState {
  const factory PhoneNumberState({
    @Default(AuthFlow.register) AuthFlow flow,
    // Live result; Continue stays disabled while it is not null.
    @Default(PhoneValidationError.empty) PhoneValidationError? validationError,
    // The message shows only after the field first loses focus.
    @Default(false) bool showValidationError,
    @Default(false) bool isSubmitting,
    // Log in with a new number, or register with a known one.
    @Default(false) bool isWrongFlow,
    // Normalized phone the OTP was sent to; the page then opens the OTP step.
    String? otpSentTo,
  }) = _PhoneNumberState;

  const PhoneNumberState._();

  PhoneValidationError? get visibleError =>
      showValidationError ? validationError : null;

  bool get canSubmit => validationError == null && !isSubmitting;
}
