import '../../../../l10n/l10n.dart';
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
