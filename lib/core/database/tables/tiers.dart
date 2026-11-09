import 'package:drift/drift.dart';

// Member tiers and the points each one starts at; added in v4.
@DataClassName('TierRow')
class Tiers extends Table {
  // silver, gold or platinum.
  TextColumn get id => text()();
  IntColumn get minPoints => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
