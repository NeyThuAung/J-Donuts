import 'package:drift/drift.dart';

import 'app_database.steps.dart';
import 'daos/app_meta_dao.dart';
import 'daos/users_dao.dart';
import 'tables/app_meta_entries.dart';
import 'tables/users.dart';

part 'app_database.g.dart';

// Every schema change bumps schemaVersion and adds a tested migration step.
@DriftDatabase(tables: [AppMetaEntries, Users], daos: [AppMetaDao, UsersDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: stepByStep(
      from1To2: (migrator, schema) => migrator.createTable(schema.users),
    ),
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
