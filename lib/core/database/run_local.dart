import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import '../exceptions/local_exception.dart';

// Repositories wrap database calls so storage errors reach the UI as
// CacheFailure through guard / guardStream.
Future<T> runLocal<T>(Future<T> Function() action) async {
  try {
    return await action();
  } catch (error, stackTrace) {
    final localException = _toLocalException(error);
    if (localException == null) rethrow;
    Error.throwWithStackTrace(localException, stackTrace);
  }
}

Stream<T> runLocalStream<T>(Stream<T> source) => source.handleError(
  (Object error, StackTrace stackTrace) => Error.throwWithStackTrace(
    _toLocalException(error) ?? error,
    stackTrace,
  ),
);

LocalException? _toLocalException(Object error) => switch (error) {
  SqliteException() => LocalException(
    error.message,
    '${error.extendedResultCode}',
  ),
  DriftWrappedException() => LocalException(error.message),
  InvalidDataException() => LocalException(error.message),
  _ => null,
};
