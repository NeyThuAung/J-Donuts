import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/validators/phone_validator.dart';

void main() {
  group('validatePhone', () {
    test('accepts the brief example with a leading 0', () {
      expect(validatePhone('09254135592'), isNull);
    });

    test('accepts 9 followed by 7 digits', () {
      expect(validatePhone('91234567'), isNull);
    });

    test('accepts 9 followed by 9 digits', () {
      expect(validatePhone('9123456789'), isNull);
    });

    test('ignores spaces and dashes', () {
      expect(validatePhone('09 254-135 592'), isNull);
    });

    test('accepts a pasted number that already has +95', () {
      expect(validatePhone('+95 9254135592'), isNull);
    });

    test('returns empty when nothing but separators is entered', () {
      expect(validatePhone(' - '), PhoneValidationError.empty);
    });

    test('returns notDigits when the number contains letters', () {
      expect(validatePhone('9254a35592'), PhoneValidationError.notDigits);
    });

    test('returns wrongLeadingDigit when the number does not start with 9', () {
      expect(
        validatePhone('8254135592'),
        PhoneValidationError.wrongLeadingDigit,
      );
    });

    test('strips only one leading 0', () {
      expect(
        validatePhone('009254135'),
        PhoneValidationError.wrongLeadingDigit,
      );
    });

    test('returns tooShort when 9 is followed by fewer than 7 digits', () {
      expect(validatePhone('9123456'), PhoneValidationError.tooShort);
    });

    test('returns tooLong when 9 is followed by more than 9 digits', () {
      expect(validatePhone('91234567890'), PhoneValidationError.tooLong);
    });
  });

  group('normalizePhone', () {
    test('turns the brief example into +959254135592', () {
      expect(normalizePhone('09254135592'), '+959254135592');
    });

    test('drops separators and a pasted +95', () {
      expect(normalizePhone('+95 925-413 5592'), '+959254135592');
    });
  });
}
