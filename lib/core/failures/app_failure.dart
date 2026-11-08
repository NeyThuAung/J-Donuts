import 'failure.dart';

/// Reading or writing the local database or secure storage failed.
class CacheFailure extends Failure {
  const CacheFailure([super.reason = 'Local storage error']);
}

/// Anything not mapped to a more specific failure.
class UnknownFailure extends Failure {
  const UnknownFailure([super.reason = 'Something went wrong']);
}
