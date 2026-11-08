import '../../../../core/core.dart';
import '../../domain/failure/auth_failure.dart';

sealed class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

final class InvalidOtpException extends AuthException {
  const InvalidOtpException() : super('Wrong verification code');

  @override
  Failure toFailure() => const InvalidOtpFailure();
}

final class PhoneNotRegisteredException extends AuthException {
  const PhoneNotRegisteredException() : super('Phone is not registered');

  @override
  Failure toFailure() => const PhoneNotRegisteredFailure();
}

final class PhoneAlreadyRegisteredException extends AuthException {
  const PhoneAlreadyRegisteredException()
    : super('Phone is already registered');

  @override
  Failure toFailure() => const PhoneAlreadyRegisteredFailure();
}

final class OtpNotVerifiedException extends AuthException {
  const OtpNotVerifiedException() : super('Phone was not verified');

  @override
  Failure toFailure() => const OtpNotVerifiedFailure();
}
