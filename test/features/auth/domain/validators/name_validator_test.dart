import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/auth_rules.dart';
import 'package:j_donuts/features/auth/domain/validators/name_validator.dart';

void main() {
  group('validateFirstName', () {
    test('accepts a Latin name with a space', () {
      expect(validateFirstName('Ye Min'), isNull);
    });

    test('accepts a Myanmar-script name', () {
      expect(validateFirstName('ရဲမင်း'), isNull);
    });

    test('accepts a one-character name', () {
      expect(validateFirstName('A'), isNull);
    });

    test('accepts exactly 50 characters', () {
      expect(validateFirstName('a' * AuthRules.nameMaxLength), isNull);
    });

    test('trims spaces before checking the length', () {
      expect(validateFirstName('  ${'a' * AuthRules.nameMaxLength}  '), isNull);
    });

    test('returns empty when nothing is entered', () {
      expect(validateFirstName(''), NameValidationError.empty);
    });

    test('returns empty when only spaces are entered', () {
      expect(validateFirstName('   '), NameValidationError.empty);
    });

    test('returns tooLong when the name has 51 characters', () {
      expect(
        validateFirstName('a' * (AuthRules.nameMaxLength + 1)),
        NameValidationError.tooLong,
      );
    });

    test('returns containsDigits when the name has a Latin digit', () {
      expect(validateFirstName('Ye Min 2'), NameValidationError.containsDigits);
    });

    test('returns containsDigits when the name has a Myanmar digit', () {
      expect(validateFirstName('ရဲမင်း၂'), NameValidationError.containsDigits);
    });

    test('returns invalidCharacters when the name has a symbol', () {
      expect(
        validateFirstName('Ye_Min!'),
        NameValidationError.invalidCharacters,
      );
    });
  });

  group('validateLastName', () {
    test('accepts an empty last name', () {
      expect(validateLastName(''), isNull);
    });

    test('accepts only spaces as an empty last name', () {
      expect(validateLastName('   '), isNull);
    });

    test('accepts a Myanmar-script last name', () {
      expect(validateLastName('ဖြိုးဝင်း'), isNull);
    });

    test('returns tooLong when the last name has 51 characters', () {
      expect(
        validateLastName('a' * (AuthRules.nameMaxLength + 1)),
        NameValidationError.tooLong,
      );
    });

    test('returns containsDigits when the last name has a digit', () {
      expect(validateLastName('Phyoe 7'), NameValidationError.containsDigits);
    });

    test('returns invalidCharacters when the last name has a symbol', () {
      expect(
        validateLastName('Phyoe@Win'),
        NameValidationError.invalidCharacters,
      );
    });
  });
}
