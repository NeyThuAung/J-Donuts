import '../../../../l10n/l10n.dart';
import '../../domain/auth_rules.dart';
import '../../domain/validators/validators.dart';

extension PhoneValidationErrorMessage on PhoneValidationError {
  String message(AppLocalizations l10n) => switch (this) {
    PhoneValidationError.empty => l10n.authPhoneErrorEmpty,
    PhoneValidationError.notDigits => l10n.authPhoneErrorNotDigits,
    PhoneValidationError.wrongLeadingDigit =>
      l10n.authPhoneErrorWrongLeadingDigit,
    PhoneValidationError.tooShort => l10n.authPhoneErrorTooShort,
    PhoneValidationError.tooLong => l10n.authPhoneErrorTooLong,
  };
}

extension NameValidationErrorMessage on NameValidationError {
  String message(AppLocalizations l10n) => switch (this) {
    NameValidationError.empty => l10n.authNameErrorEmpty,
    NameValidationError.tooLong => l10n.authNameErrorTooLong(
      AuthRules.nameMaxLength,
    ),
    NameValidationError.containsDigits => l10n.authNameErrorDigits,
    NameValidationError.invalidCharacters => l10n.authNameErrorInvalid,
  };
}
