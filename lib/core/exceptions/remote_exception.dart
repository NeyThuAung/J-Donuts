import '../failures/failure.dart';
import '../failures/remote_failure.dart';
import 'app_exception.dart';

/// Thrown by repositories when a network call fails.
sealed class RemoteException extends AppException {
  const RemoteException(super.message, [super.code]);
}

final class InternetConnectionException extends RemoteException {
  const InternetConnectionException(super.message, [super.code]);

  @override
  Failure toFailure() => ConnectionFailure(message);
}

final class TimeoutException extends RemoteException {
  const TimeoutException(super.message, [super.code]);

  @override
  Failure toFailure() => TimeoutFailure(message);
}

final class NotFoundException extends RemoteException {
  const NotFoundException(super.message, [super.code]);

  @override
  Failure toFailure() => NotFoundFailure(message);
}

final class BadRequestException extends RemoteException {
  const BadRequestException(super.message, [super.code]);

  @override
  Failure toFailure() => BadRequestFailure(message);
}

final class UnauthorizedException extends RemoteException {
  const UnauthorizedException(super.message, [super.code]);

  @override
  Failure toFailure() => SessionFailure(message);
}

final class ServerException extends RemoteException {
  const ServerException(super.message, [super.code]);

  @override
  Failure toFailure() => ServerFailure(message);
}
