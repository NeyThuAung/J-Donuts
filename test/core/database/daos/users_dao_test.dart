import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/database/database.dart';

const _phone = '+959254135592';

UsersCompanion _user({String phone = _phone, String? lastName}) =>
    UsersCompanion.insert(
      phone: phone,
      firstName: 'Ye Min',
      lastName: Value(lastName),
      dateOfBirth: DateTime(1980, 5),
    );

void main() {
  group('UsersDao', () {
    late AppDatabase database;
    late UsersDao dao;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      dao = database.usersDao;
    });

    tearDown(() => database.close());

    test('returns null for a phone that never registered', () async {
      expect(await dao.findByPhone(_phone), isNull);
    });

    test('finds an inserted user by phone and by id', () async {
      final id = await dao.insertUser(_user(lastName: 'Phyoe Win'));

      final byPhone = await dao.findByPhone(_phone);
      final byId = await dao.findById(id);

      expect(byPhone?.id, id);
      expect(byId?.firstName, 'Ye Min');
      expect(byId?.lastName, 'Phyoe Win');
      expect(byId?.dateOfBirth, DateTime(1980, 5));
    });

    test('stores a missing last name as null', () async {
      final id = await dao.insertUser(_user());

      expect((await dao.findById(id))?.lastName, isNull);
    });

    test('sets createdAt when a user is inserted', () async {
      final id = await dao.insertUser(_user());

      expect((await dao.findById(id))?.createdAt, isNotNull);
    });

    test('rejects a second user with the same phone', () async {
      await dao.insertUser(_user());

      await expectLater(
        dao.insertUser(_user()),
        throwsA(isA<SqliteException>()),
      );
    });

    test('keeps users with different phones apart', () async {
      await dao.insertUser(_user());
      await dao.insertUser(_user(phone: '+95991234567'));

      expect(await database.select(database.users).get(), hasLength(2));
    });
  });
}
