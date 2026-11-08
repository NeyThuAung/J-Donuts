import 'package:drift/drift.dart'
    show DriftWrappedException, InvalidDataException;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/core/database/database.dart';

const _insertWithoutValue =
    "INSERT INTO app_meta (key, value) VALUES ('k', NULL)";

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase(NativeDatabase.memory()));
  tearDown(() => database.close());

  group('runLocal', () {
    test('returns the value of a successful call', () async {
      await database.appMetaDao.writeValue('k', 'v');

      expect(await runLocal(() => database.appMetaDao.readValue('k')), 'v');
    });

    test('turns a SQLite error into a LocalException with its code', () async {
      await expectLater(
        runLocal(() => database.customStatement(_insertWithoutValue)),
        throwsA(
          isA<LocalException>().having((e) => e.code, 'code', isNotNull),
        ),
      );
    });

    test('turns a Drift wrapped error into a LocalException', () async {
      await expectLater(
        runLocal<void>(
          () => throw DriftWrappedException(message: 'could not open'),
        ),
        throwsA(
          isA<LocalException>().having(
            (e) => e.message,
            'message',
            'could not open',
          ),
        ),
      );
    });

    test('turns invalid data into a LocalException', () async {
      await expectLater(
        runLocal<void>(() => throw InvalidDataException('bad row')),
        throwsA(isA<LocalException>()),
      );
    });

    test('lets errors that are not storage errors pass through', () async {
      await expectLater(
        runLocal<void>(() => throw StateError('bug')),
        throwsA(isA<StateError>()),
      );
    });

    test(
      'a storage error reaches the UI as a CacheFailure via guard',
      () async {
        final result = await guard(
          () => runLocal(() => database.customStatement(_insertWithoutValue)),
        );

        expect(result, isA<Failed<void>>());
        expect((result as Failed<void>).failure, isA<CacheFailure>());
      },
    );
  });

  group('runLocalStream', () {
    test('passes values through unchanged', () async {
      await expectLater(
        runLocalStream(Stream.fromIterable([1, 2])),
        emitsInOrder([1, 2, emitsDone]),
      );
    });

    test('turns a storage error into a LocalException and keeps going', () {
      final source = Stream<int>.multi((controller) {
        controller
          ..add(1)
          ..addError(InvalidDataException('bad row'))
          ..add(2)
          ..close();
      });

      expect(
        runLocalStream(source),
        emitsInOrder([
          1,
          emitsError(isA<LocalException>()),
          2,
          emitsDone,
        ]),
      );
    });

    test('lets other stream errors pass through', () {
      expect(
        runLocalStream(Stream<int>.error(StateError('bug'))),
        emitsError(isA<StateError>()),
      );
    });
  });
}
