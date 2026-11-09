import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import '../exceptions/remote_exception.dart';
import 'dio_exception_mapper.dart';

// Repositories wrap API calls so network errors and malformed responses
// reach the UI as typed failures through guard.
Future<T> runRemote<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on DioException catch (error, stackTrace) {
    Error.throwWithStackTrace(error.toRemoteException(), stackTrace);
  } on CheckedFromJsonException catch (error, stackTrace) {
    Error.throwWithStackTrace(_invalidResponse(error.message), stackTrace);
  } on FormatException catch (error, stackTrace) {
    Error.throwWithStackTrace(_invalidResponse(error.message), stackTrace);
  }
}

ServerException _invalidResponse(String? detail) =>
    ServerException('Invalid response: ${detail ?? 'unknown'}');
