import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/database/database.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase(NativeDatabase.memory()));
    tearDown(() => database.close());

    test('is at schema version 4, which adds tiers and challenges', () {
      expect(database.schemaVersion, 4);
    });

    test('creates every table on first open', () async {
      final tables = await database
          .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
          .map((row) => row.read<String>('name'))
          .get();

      expect(
        tables,
        containsAll([
          'app_meta',
          'users',
          'products',
          'banners',
          'sections',
          'section_products',
          'shops',
          'members',
          'tiers',
          'challenges',
        ]),
      );
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
