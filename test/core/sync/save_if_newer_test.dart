import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';

ApiEnvelope<String> _envelope(int version, {String? data = 'data'}) =>
    ApiEnvelope(
      data: data,
      meta: ApiMeta(version: version),
    );

void main() {
  group('saveIfNewer', () {
    late List<(String, int)> saved;

    setUp(() => saved = []);

    Future<bool> save(ApiEnvelope<String> envelope, int? stored) => saveIfNewer(
      envelope,
      storedVersion: () async => stored,
      save: (data, version) async => saved.add((data, version)),
    );

    test('saves when nothing is stored yet', () async {
      expect(await save(_envelope(1), null), isTrue);
      expect(saved, [('data', 1)]);
    });

    test('saves a newer version over the stored one', () async {
      expect(await save(_envelope(3), 2), isTrue);
      expect(saved, [('data', 3)]);
    });

    test('ignores the same version', () async {
      expect(await save(_envelope(2), 2), isFalse);
      expect(saved, isEmpty);
    });

    test(
      'ignores an older version, so a stale seed never undoes a refresh',
      () async {
        expect(await save(_envelope(1), 2), isFalse);
        expect(saved, isEmpty);
      },
    );

    test(
      'throws a ServerException when the response carries an error',
      () async {
        const envelope = ApiEnvelope<String>(
          error: ApiError(code: 'oops', message: 'Broken'),
          meta: ApiMeta(version: 5),
        );

        await expectLater(
          save(envelope, null),
          throwsA(isA<ServerException>()),
        );
        expect(saved, isEmpty);
      },
    );

    test('throws a ServerException when the response has no data', () async {
      await expectLater(
        save(_envelope(5, data: null), null),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
