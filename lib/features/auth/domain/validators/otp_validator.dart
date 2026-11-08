import '../auth_rules.dart';

enum OtpValidationError { incomplete, notDigits, tooLong }

final _digitsOnly = RegExp(r'^\d*$');

/// Checks the shape only; whether the code is right is the repository's call.
OtpValidationError? validateOtp(String code) {
  if (!_digitsOnly.hasMatch(code)) return OtpValidationError.notDigits;
  if (code.length < AuthRules.otpLength) return OtpValidationError.incomplete;
  if (code.length > AuthRules.otpLength) return OtpValidationError.tooLong;
  return null;
}
