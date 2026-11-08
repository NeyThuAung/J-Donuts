import 'failure.dart';

class ConnectionFailure extends Failure {
  const ConnectionFailure([super.reason = 'No internet connection']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.reason = 'Connection timed out']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.reason = 'Not found']);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure([super.reason = 'Bad request']);
}

class SessionFailure extends Failure {
  const SessionFailure([super.reason = 'Session expired']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.reason = 'Server error']);
}
