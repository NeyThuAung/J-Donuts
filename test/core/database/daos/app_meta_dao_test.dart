import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/database/database.dart';

const _key = 'onboarding_seen';

void main() {
  group('AppMetaDao', () {
    late AppDatabase database;
    late AppMetaDao dao;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      dao = database.appMetaDao;
    });

    tearDown(() => database.close());

    test('returns null for a key that was never written', () async {
      expect(await dao.readValue(_key), isNull);
    });

    test('reads back the value that was written', () async {
      await dao.writeValue(_key, 'true');

      expect(await dao.readValue(_key), 'true');
    });

    test('replaces the value when the same key is written again', () async {
      await dao.writeValue(_key, '1');
      await dao.writeValue(_key, '2');

      expect(await dao.readValue(_key), '2');
      expect(
        await database.select(database.appMetaEntries).get(),
        hasLength(1),
      );
    });

    test('keeps values of different keys apart', () async {
      await dao.writeValue(_key, 'true');
      await dao.writeValue('seed_version', '3');

      expect(await dao.readValue(_key), 'true');
      expect(await dao.readValue('seed_version'), '3');
    });

    test('removes only the given key', () async {
      await dao.writeValue(_key, 'true');
      await dao.writeValue('seed_version', '3');

      await dao.removeValue(_key);

      expect(await dao.readValue(_key), isNull);
      expect(await dao.readValue('seed_version'), '3');
    });

    test('watch emits the current value and every change', () async {
      final values = dao.watchValue(_key);

      final expectation = expectLater(
        values,
        emitsInOrder([isNull, 'a', 'b', isNull]),
      );
      await pumpEventQueue();
      await dao.writeValue(_key, 'a');
      await pumpEventQueue();
      await dao.writeValue(_key, 'b');
      await pumpEventQueue();
      await dao.removeValue(_key);

      await expectation;
    });
  });
}
