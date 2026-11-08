part of 'date_of_birth_cubit.dart';

@freezed
abstract class DateOfBirthState with _$DateOfBirthState {
  const factory DateOfBirthState({
    @Default('') String phone,
    @Default('') String firstName,
    String? lastName,
    // Null until first picked.
    int? year,
    int? month,
    int? day,
    DateOfBirthValidationError? validationError,
    @Default(false) bool isSubmitting,
    // Set once registered; the page signs the new member in.
    UserEntity? registeredUser,
  }) = _DateOfBirthState;

  const DateOfBirthState._();

  bool get hasDate => year != null && month != null && day != null;

  bool get canSubmit => hasDate && validationError == null && !isSubmitting;
}
