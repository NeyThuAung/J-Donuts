import '../failures/failure.dart';

/// Base of every exception the data layer throws on purpose.
///
/// Each subtype knows the [Failure] it becomes, so use cases convert with
/// `e.toFailure()` and never inspect exception types themselves.
abstract class AppException implements Exception {
  const AppException(this.message, [this.code]);

  final String message;
  final String? code;

  Failure toFailure();

  @override
  String toString() => '$runtimeType($message${code == null ? '' : ', $code'})';
}
