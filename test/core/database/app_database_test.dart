import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/database/database.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase(NativeDatabase.memory()));
    tearDown(() => database.close());

    test('starts at schema version 1', () {
      expect(database.schemaVersion, 1);
    });

    test('creates the app_meta table on first open', () async {
      final tables = await database
          .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
          .map((row) => row.read<String>('name'))
          .get();

      expect(tables, contains('app_meta'));
    });

    test('turns foreign key checks on when it opens', () async {
      final row = await database
          .customSelect('PRAGMA foreign_keys')
          .getSingle();

      expect(row.read<int>('foreign_keys'), 1);
    });

    test('rejects a meta entry without a value', () async {
      await expectLater(
        database.customStatement(
          "INSERT INTO app_meta (key, value) VALUES ('k', NULL)",
        ),
        throwsA(isA<SqliteException>()),
      );
    });

    test('stores DateTime values as text', () {
      expect(database.typeMapping.storeDateTimesAsText, isTrue);
    });
  });
}
