import '../auth_rules.dart';

enum DateOfBirthValidationError { invalidDate, inFuture, tooYoung }

/// [today] is passed in so the rule is testable; only its date part is used.
DateOfBirthValidationError? validateDateOfBirth({
  required int year,
  required int month,
  required int day,
  required DateTime today,
}) {
  if (!isRealDate(year: year, month: month, day: day)) {
    return DateOfBirthValidationError.invalidDate;
  }
  final birth = DateTime(year, month, day);
  final todayDate = DateTime(today.year, today.month, today.day);
  if (birth.isAfter(todayDate)) return DateOfBirthValidationError.inFuture;
  if (ageOn(birth, todayDate) < AuthRules.minimumAge) {
    return DateOfBirthValidationError.tooYoung;
  }
  return null;
}

/// False for dates DateTime would roll over, such as 31 April or 29 February 2023.
bool isRealDate({required int year, required int month, required int day}) {
  final date = DateTime(year, month, day);
  return date.year == year && date.month == month && date.day == day;
}

/// Whole years; a 29 February birthday counts from 1 March in other years.
int ageOn(DateTime birth, DateTime today) {
  final age = today.year - birth.year;
  final hadBirthday =
      today.month > birth.month ||
      (today.month == birth.month && today.day >= birth.day);
  return hadBirthday ? age : age - 1;
}
