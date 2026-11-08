import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/database/database.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;

// Snapshots in drift_schemas/ come from `dart run drift_dev make-migrations`.
void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  group('AppDatabase schema', () {
    // Fails when a table changes without a version bump and a new snapshot.
    test('a fresh database matches the snapshot of its version', () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      await verifier.migrateAndValidate(database, database.schemaVersion);
    });

    test('has a committed snapshot for the current schema version', () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      expect(GeneratedHelper.versions.last, database.schemaVersion);
    });
  });

  group('AppDatabase upgrades', () {
    test('each older version upgrades to the current schema', () async {
      for (final from in GeneratedHelper.versions.take(
        GeneratedHelper.versions.length - 1,
      )) {
        final connection = (await verifier.schemaAt(from)).newConnection();
        final database = AppDatabase(connection);

        await verifier.migrateAndValidate(database, database.schemaVersion);
        await database.close();
      }
    });

    test('v1 to v2 adds users and keeps app_meta values', () async {
      final schema = await verifier.schemaAt(1);
      final oldDatabase = v1.DatabaseAtV1(schema.newConnection());
      await oldDatabase
          .into(oldDatabase.appMeta)
          .insert(v1.AppMetaCompanion.insert(key: 'seed_version', value: '1'));
      await oldDatabase.close();

      final database = AppDatabase(schema.newConnection());
      addTearDown(database.close);
      await verifier.migrateAndValidate(database, 2);

      expect(await database.appMetaDao.readValue('seed_version'), '1');
      expect(await database.select(database.users).get(), isEmpty);
    });
  });
}
