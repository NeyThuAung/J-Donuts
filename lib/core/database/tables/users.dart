import 'package:drift/drift.dart';

// Registered members of the fake auth backend; added in schema v2.
@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Normalized, e.g. +959254135592.
  TextColumn get phone => text().unique()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
