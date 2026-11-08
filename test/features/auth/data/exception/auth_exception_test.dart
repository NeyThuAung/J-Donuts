import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/data/exception/auth_exception.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';

void main() {
  group('AuthException.toFailure', () {
    test('maps each auth error to its own failure', () {
      expect(const InvalidOtpException().toFailure(), isA<InvalidOtpFailure>());
      expect(
        const PhoneNotRegisteredException().toFailure(),
        isA<PhoneNotRegisteredFailure>(),
      );
      expect(
        const PhoneAlreadyRegisteredException().toFailure(),
        isA<PhoneAlreadyRegisteredFailure>(),
      );
      expect(
        const OtpNotVerifiedException().toFailure(),
        isA<OtpNotVerifiedFailure>(),
      );
    });
  });
}
