import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/domain/validators/date_of_birth_validator.dart';

void main() {
  final today = DateTime(2026, 11, 8, 15, 30);

  DateOfBirthValidationError? validate(int year, int month, int day) =>
      validateDateOfBirth(year: year, month: month, day: day, today: today);

  group('validateDateOfBirth', () {
    test('accepts the design example, 1 May 1980', () {
      expect(validate(1980, 5, 1), isNull);
    });

    test('returns invalidDate for 31 April', () {
      expect(validate(1990, 4, 31), DateOfBirthValidationError.invalidDate);
    });

    test('accepts 29 February in a leap year', () {
      expect(validate(2000, 2, 29), isNull);
    });

    test('returns invalidDate for 29 February in a non-leap year', () {
      expect(validate(2001, 2, 29), DateOfBirthValidationError.invalidDate);
    });

    test(
      'returns invalidDate for 29 February 1900, a century non-leap year',
      () {
        expect(validate(1900, 2, 29), DateOfBirthValidationError.invalidDate);
      },
    );

    test('returns invalidDate for month 13', () {
      expect(validate(1990, 13, 1), DateOfBirthValidationError.invalidDate);
    });

    test('returns invalidDate for day 0', () {
      expect(validate(1990, 1, 0), DateOfBirthValidationError.invalidDate);
    });

    test('returns inFuture for tomorrow', () {
      expect(validate(2026, 11, 9), DateOfBirthValidationError.inFuture);
    });

    test('returns tooYoung for someone born today', () {
      expect(validate(2026, 11, 8), DateOfBirthValidationError.tooYoung);
    });

    test('accepts someone who turns 13 today', () {
      expect(validate(2013, 11, 8), isNull);
    });

    test('returns tooYoung for someone who turns 13 tomorrow', () {
      expect(validate(2013, 11, 9), DateOfBirthValidationError.tooYoung);
    });
  });

  group('ageOn', () {
    test('counts a 29 February birthday from 1 March in a non-leap year', () {
      final birth = DateTime(2012, 2, 29);
      expect(ageOn(birth, DateTime(2025, 2, 28)), 12);
      expect(ageOn(birth, DateTime(2025, 3)), 13); // 1 March
    });
  });
}
