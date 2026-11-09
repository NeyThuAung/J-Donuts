part of 'phone_number_cubit.dart';

@freezed
abstract class PhoneNumberState with _$PhoneNumberState {
  const factory PhoneNumberState({
    @Default(AuthFlow.register) AuthFlow flow,
    @Default(PhoneValidationError.empty) PhoneValidationError? validationError,
    @Default(false) bool showValidationError,
    @Default(false) bool isSubmitting,
    @Default(false) bool isWrongFlow,
    String? otpSentTo,
  }) = _PhoneNumberState;

  const PhoneNumberState._();

  PhoneValidationError? get visibleError =>
      showValidationError ? validationError : null;

  bool get canSubmit => validationError == null && !isSubmitting;
}
