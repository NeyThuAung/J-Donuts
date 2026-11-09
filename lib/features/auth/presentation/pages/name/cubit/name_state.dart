part of 'name_cubit.dart';

@freezed
abstract class NameState with _$NameState {
  const factory NameState({
    @Default(NameValidationError.empty) NameValidationError? firstNameError,
    NameValidationError? lastNameError,
    @Default(false) bool showFirstNameError,
    @Default(false) bool showLastNameError,
  }) = _NameState;

  const NameState._();

  NameValidationError? get visibleFirstNameError =>
      showFirstNameError ? firstNameError : null;

  NameValidationError? get visibleLastNameError =>
      showLastNameError ? lastNameError : null;

  bool get canContinue => firstNameError == null && lastNameError == null;
}
