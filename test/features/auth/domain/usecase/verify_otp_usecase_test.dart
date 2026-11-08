import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/data/exception/auth_exception.dart';
import 'package:j_donuts/features/auth/domain/entity/otp_result.dart';
import 'package:j_donuts/features/auth/domain/entity/user_entity.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';
import 'package:j_donuts/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '_mock_auth_repository.dart';

const _param = VerifyOtpParam(phone: '+959254135592', code: '123456');

void main() {
  late MockAuthRepository repository;
  late VerifyOtpUseCase verifyOtp;

  setUp(() {
    repository = MockAuthRepository();
    verifyOtp = VerifyOtpUseCase(repository);
  });

  void whenVerified(Future<UserEntity?> Function() answer) => when(
    () => repository.verifyOtp(phone: _param.phone, code: _param.code),
  ).thenAnswer((_) => answer());

  group('VerifyOtpUseCase', () {
    test('signs in a registered member', () async {
      final user = UserEntity(
        id: '1',
        phone: _param.phone,
        firstName: 'Ye Min',
        dateOfBirth: DateTime(1980, 5),
      );
      whenVerified(() async => user);

      final result = await verifyOtp(_param);

      expect(result.dataOrNull, isA<OtpSignedIn>());
      expect((result.dataOrNull! as OtpSignedIn).user, user);
    });

    test('asks a new number to register', () async {
      whenVerified(() async => null);

      final result = await verifyOtp(_param);

      expect(result.dataOrNull, isA<OtpNeedsRegistration>());
    });

    test('returns InvalidOtpFailure for a wrong code', () async {
      whenVerified(() => throw const InvalidOtpException());

      final result = await verifyOtp(_param);

      expect(result, const Failed<OtpResult>(InvalidOtpFailure()));
    });
  });
}
