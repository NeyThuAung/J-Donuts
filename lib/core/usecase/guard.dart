import 'dart:async';

import '../data_state/data_state.dart';
import '../exceptions/app_exception.dart';
import '../failures/app_failure.dart';
import '../failures/failure.dart';

Future<DataState<T>> guard<T>(Future<T> Function() action) async {
  try {
    return Success(await action());
  } catch (error) {
    return Failed(_toFailure(error), error);
  }
}

/// Errors become [Failed] events; the stream stays open.
Stream<DataState<T>> guardStream<T>(Stream<T> source) => source.transform(
  StreamTransformer<T, DataState<T>>.fromHandlers(
    handleData: (data, sink) => sink.add(Success(data)),
    handleError: (error, _, sink) => sink.add(Failed(_toFailure(error), error)),
  ),
);

Failure _toFailure(Object error) =>
    error is AppException ? error.toFailure() : const UnknownFailure();
