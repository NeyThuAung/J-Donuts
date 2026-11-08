import '../../../../core/failures/failure.dart';

final class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure([super.reason = 'Wrong verification code']);
}

final class PhoneNotRegisteredFailure extends Failure {
  const PhoneNotRegisteredFailure([super.reason = 'Phone is not registered']);
}

final class PhoneAlreadyRegisteredFailure extends Failure {
  const PhoneAlreadyRegisteredFailure([
    super.reason = 'Phone is already registered',
  ]);
}

final class OtpNotVerifiedFailure extends Failure {
  const OtpNotVerifiedFailure([super.reason = 'Phone was not verified']);
}
