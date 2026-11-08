import '../failures/failure.dart';

abstract class AppException implements Exception {
  const AppException(this.message, [this.code]);

  final String message;
  final String? code;

  Failure toFailure();

  @override
  String toString() => '$runtimeType($message${code == null ? '' : ', $code'})';
}
