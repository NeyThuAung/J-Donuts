import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';

void main() {
  group('guard', () {
    test('returns Success with the value when the action completes', () async {
      expect(await guard(() async => 'ok'), const Success('ok'));
    });

    test(
      'returns the exception failure when the action throws an AppException',
      () async {
        final result = await guard<String>(
          () async => throw const LocalException('disk full'),
        );

        expect(result, const Failed<String>(CacheFailure('disk full')));
      },
    );

    test(
      'returns UnknownFailure and keeps the error for anything else',
      () async {
        final error = StateError('boom');
        final result = await guard<String>(() async => throw error);

        expect(result, const Failed<String>(UnknownFailure()));
        expect((result as Failed<String>).error, same(error));
      },
    );
  });

  group('guardStream', () {
    test('wraps data in Success and errors in Failed without closing', () {
      final source = Stream<int>.fromIterable([1, 2]).asyncExpand(
        (value) => value == 2
            ? Stream<int>.error(const LocalException('read failed'))
            : Stream<int>.value(value),
      );

      expect(
        guardStream(source),
        emitsInOrder(<Object>[
          const Success(1),
          const Failed<int>(CacheFailure('read failed')),
          emitsDone,
        ]),
      );
    });
  });
}
