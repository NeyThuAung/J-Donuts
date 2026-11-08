import '../auth_rules.dart';

enum PhoneValidationError {
  empty,
  notDigits,
  wrongLeadingDigit,
  tooShort,
  tooLong,
}

final _separators = RegExp(r'[\s-]');
final _digitsOnly = RegExp(r'^\d+$');

PhoneValidationError? validatePhone(String input) {
  final local = _localNumber(input);
  if (local.isEmpty) return PhoneValidationError.empty;
  if (!_digitsOnly.hasMatch(local)) return PhoneValidationError.notDigits;
  if (!local.startsWith(AuthRules.phoneLeadingDigit)) {
    return PhoneValidationError.wrongLeadingDigit;
  }
  final digitsAfterLeading = local.length - 1;
  if (digitsAfterLeading < AuthRules.phoneMinDigitsAfterLeading) {
    return PhoneValidationError.tooShort;
  }
  if (digitsAfterLeading > AuthRules.phoneMaxDigitsAfterLeading) {
    return PhoneValidationError.tooLong;
  }
  return null;
}

/// Call only after [validatePhone] returns null: `09254135592` → `+959254135592`.
String normalizePhone(String input) =>
    '${AuthRules.countryCode}${_localNumber(input)}';

// Strips spaces, dashes, a pasted +95 and one leading 0.
String _localNumber(String input) {
  var number = input.replaceAll(_separators, '');
  if (number.startsWith(AuthRules.countryCode)) {
    number = number.substring(AuthRules.countryCode.length);
  }
  return number.startsWith('0') ? number.substring(1) : number;
}
