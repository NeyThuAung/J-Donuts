import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/data/exception/auth_exception.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';
import 'package:j_donuts/features/auth/domain/usecase/request_otp_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '_mock_auth_repository.dart';

const _phone = '+959254135592';

void main() {
  late MockAuthRepository repository;
  late RequestOtpUseCase requestOtp;

  setUp(() {
    repository = MockAuthRepository();
    requestOtp = RequestOtpUseCase(repository);
  });

  group('RequestOtpUseCase', () {
    test('asks the repository for a code for the given flow', () async {
      when(
        () => repository.requestOtp(phone: _phone, flow: AuthFlow.logIn),
      ).thenAnswer((_) async {});

      final result = await requestOtp(
        const RequestOtpParam(phone: _phone, flow: AuthFlow.logIn),
      );

      expect(result, isA<Success<void>>());
    });

    test('returns PhoneNotRegisteredFailure for an unknown number', () async {
      when(
        () => repository.requestOtp(phone: _phone, flow: AuthFlow.logIn),
      ).thenThrow(const PhoneNotRegisteredException());

      final result = await requestOtp(
        const RequestOtpParam(phone: _phone, flow: AuthFlow.logIn),
      );

      expect(result, const Failed<void>(PhoneNotRegisteredFailure()));
    });
  });
}
