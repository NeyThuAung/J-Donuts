import 'package:drift/drift.dart';

import 'daos/app_meta_dao.dart';
import 'tables/app_meta_entries.dart';

part 'app_database.g.dart';

// Every schema change bumps schemaVersion and adds a tested migration step.
@DriftDatabase(tables: [AppMetaEntries], daos: [AppMetaDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
