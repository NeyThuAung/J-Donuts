import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/validators/otp_validator.dart';

void main() {
  group('validateOtp', () {
    test('accepts 6 digits', () {
      expect(validateOtp('123456'), isNull);
    });

    test('returns incomplete when nothing is entered', () {
      expect(validateOtp(''), OtpValidationError.incomplete);
    });

    test('returns incomplete when fewer than 6 digits are entered', () {
      expect(validateOtp('12345'), OtpValidationError.incomplete);
    });

    test('returns tooLong when more than 6 digits are entered', () {
      expect(validateOtp('1234567'), OtpValidationError.tooLong);
    });

    test('returns notDigits when the code contains a letter', () {
      expect(validateOtp('12a456'), OtpValidationError.notDigits);
    });

    test('returns notDigits when the code contains a space', () {
      expect(validateOtp('123 56'), OtpValidationError.notDigits);
    });
  });
}
