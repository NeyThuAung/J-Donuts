import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';

void main() {
  group('Success', () {
    const DataState<int> state = Success(7);

    test('runs the onSuccess handler with the data', () {
      expect(state.onSuccess((data) => data * 2), 14);
    });

    test('skips the onError handler', () {
      expect(state.onError((failure) => failure.reason), isNull);
    });

    test('exposes the data through dataOrNull', () {
      expect(state.dataOrNull, 7);
    });

    test('equals another Success with the same data', () {
      expect(state, const Success(7));
    });
  });

  group('Failed', () {
    const DataState<int> state = Failed(NotFoundFailure('missing'));

    test('runs the onError handler with the failure', () {
      expect(state.onError((failure) => failure.reason), 'missing');
    });

    test('skips the onSuccess handler', () {
      expect(state.onSuccess((data) => data * 2), isNull);
    });

    test('returns null from dataOrNull', () {
      expect(state.dataOrNull, isNull);
    });

    test('equals another Failed with an equal failure', () {
      expect(state, const Failed<int>(NotFoundFailure('missing')));
    });
  });

  group('Failure equality', () {
    test('is equal when type and reason match', () {
      expect(const CacheFailure('x'), equals(const CacheFailure('x')));
    });

    test('is not equal when the type differs with the same reason', () {
      expect(const CacheFailure('x'), isNot(equals(const UnknownFailure('x'))));
    });
  });
}
