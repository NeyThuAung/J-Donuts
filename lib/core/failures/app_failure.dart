import 'failure.dart';

class CacheFailure extends Failure {
  const CacheFailure([super.reason = 'Local storage error']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.reason = 'Something went wrong']);
}
