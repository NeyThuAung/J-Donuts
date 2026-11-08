import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/database/database.dart';

import 'generated/schema.dart';

// Snapshots in drift_schemas/ come from `dart run drift_dev make-migrations`;
// it adds a step-by-step upgrade test here once a second version exists.
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
}
