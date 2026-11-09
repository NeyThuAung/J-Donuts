import 'package:drift/drift.dart';

// The one member record every screen reads; added in v3.
@DataClassName('MemberRow')
class Members extends Table {
  static const singleRowId = 1;

  /// Always [singleRowId]; MembersDao only reads and writes that row.
  IntColumn get id => integer()();

  /// Seeded name; the registered first name takes its place on screen.
  TextColumn get name => text()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get tier => text()();
  IntColumn get points => integer()();
  TextColumn get nextTier => text().nullable()();
  IntColumn get pointsToNextTier => integer().nullable()();
  IntColumn get notificationCount => integer()();
  IntColumn get availableRewards => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
