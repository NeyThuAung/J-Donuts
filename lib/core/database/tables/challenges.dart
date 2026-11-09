import 'package:drift/drift.dart';

// Rewards challenges, one list per tab; added in v4.
@DataClassName('ChallengeRow')
class Challenges extends Table {
  TextColumn get id => text()();

  // earn or gift.
  TextColumn get tab => text()();
  TextColumn get title => text()();
  IntColumn get goal => integer()();
  IntColumn get progress => integer()();
  IntColumn get rewardPoints => integer()();

  // donutQuarters or arc.
  TextColumn get artwork => text()();
  TextColumn get imageUrl => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
