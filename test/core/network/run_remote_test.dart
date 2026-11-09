import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';

DioException _dio(DioExceptionType type, {int? status, Object? error}) =>
    DioException(
      requestOptions: RequestOptions(),
      type: type,
      error: error,
      response: status == null
          ? null
          : Response(requestOptions: RequestOptions(), statusCode: status),
    );

Future<Failure> _failureOf(Object error) async {
  final result = await guard(
    () => runRemote<void>(
      () async => Error.throwWithStackTrace(error, StackTrace.current),
    ),
  );
  return (result as Failed).failure;
}

void main() {
  group('runRemote', () {
    test('returns the response when the call succeeds', () async {
      expect(await runRemote(() async => 42), 42);
    });

    test('turns airplane mode into a ConnectionFailure', () async {
      expect(
        await _failureOf(_dio(DioExceptionType.connectionError)),
        isA<ConnectionFailure>(),
      );
      expect(
        await _failureOf(
          _dio(DioExceptionType.unknown, error: const SocketException('x')),
        ),
        isA<ConnectionFailure>(),
      );
    });

    test('turns every kind of timeout into a TimeoutFailure', () async {
      for (final type in [
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
      ]) {
        expect(await _failureOf(_dio(type)), isA<TimeoutFailure>());
      }
    });

    test('maps HTTP status codes to typed failures', () async {
      Future<Failure> status(int code) =>
          _failureOf(_dio(DioExceptionType.badResponse, status: code));

      expect(await status(400), isA<BadRequestFailure>());
      expect(await status(401), isA<SessionFailure>());
      expect(await status(403), isA<SessionFailure>());
      expect(await status(404), isA<NotFoundFailure>());
      expect(await status(500), isA<ServerFailure>());
    });

    test('treats a malformed response as a ServerFailure', () async {
      expect(
        await _failureOf(const FormatException('bad json')),
        isA<ServerFailure>(),
      );
    });
  });
}
