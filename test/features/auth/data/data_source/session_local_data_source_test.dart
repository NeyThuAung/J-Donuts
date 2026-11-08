import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/config/secure_storage_config.dart';
import 'package:j_donuts/features/auth/data/data_source/session_local_data_source.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecureStorage extends Mock implements FlutterSecureStorage {}

const _key = SecureStorageConfig.sessionUserIdKey;

void main() {
  late _MockSecureStorage storage;
  late SessionLocalDataSourceImpl dataSource;

  setUp(() {
    storage = _MockSecureStorage();
    dataSource = SessionLocalDataSourceImpl(storage);
  });

  group('SessionLocalDataSourceImpl', () {
    test('reads the user id from the session key', () async {
      when(() => storage.read(key: _key)).thenAnswer((_) async => '7');

      expect(await dataSource.readUserId(), '7');
    });

    test('writes the user id under the session key', () async {
      when(
        () => storage.write(key: _key, value: '7'),
      ).thenAnswer((_) async {});

      await dataSource.saveUserId('7');

      verify(() => storage.write(key: _key, value: '7')).called(1);
    });

    test('deletes only the session key on clear', () async {
      when(() => storage.delete(key: _key)).thenAnswer((_) async {});

      await dataSource.clear();

      verify(() => storage.delete(key: _key)).called(1);
      verifyNever(() => storage.deleteAll());
    });
  });
}
