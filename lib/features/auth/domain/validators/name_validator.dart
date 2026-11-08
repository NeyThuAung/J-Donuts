import '../auth_rules.dart';

enum NameValidationError { empty, tooLong, containsDigits, invalidCharacters }

// Any script's digits, Myanmar ၀–၉ included.
final _anyDigit = RegExp(r'\p{Nd}', unicode: true);
// Letters plus combining marks, which Myanmar script needs.
final _lettersAndSpaces = RegExp(r'^[\p{L}\p{M} ]+$', unicode: true);

NameValidationError? validateFirstName(String input) {
  final name = input.trim();
  if (name.isEmpty) return NameValidationError.empty;
  return _validateCharacters(name);
}

/// Optional: many Myanmar names have no family name.
NameValidationError? validateLastName(String input) {
  final name = input.trim();
  if (name.isEmpty) return null;
  return _validateCharacters(name);
}

NameValidationError? _validateCharacters(String name) {
  if (name.runes.length > AuthRules.nameMaxLength) {
    return NameValidationError.tooLong;
  }
  if (_anyDigit.hasMatch(name)) return NameValidationError.containsDigits;
  if (!_lettersAndSpaces.hasMatch(name)) {
    return NameValidationError.invalidCharacters;
  }
  return null;
}

final _repeatedSpaces = RegExp(r'\s+');

/// Trims and collapses inner spaces: "  Ye   Min " → "Ye Min".
String normalizeName(String input) =>
    input.trim().replaceAll(_repeatedSpaces, ' ');
