import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/data/exception/auth_exception.dart';
import 'package:j_donuts/features/auth/domain/entity/registration_request.dart';
import 'package:j_donuts/features/auth/domain/entity/user_entity.dart';
import 'package:j_donuts/features/auth/domain/failure/auth_failure.dart';
import 'package:j_donuts/features/auth/domain/usecase/register_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '_mock_auth_repository.dart';

const _phone = '+959254135592';
final _dateOfBirth = DateTime(1980, 5);

RegistrationRequest _request({String firstName = 'Ye Min', String? lastName}) =>
    RegistrationRequest(
      phone: _phone,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: _dateOfBirth,
    );

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase register;
  final user = UserEntity(
    id: '1',
    phone: _phone,
    firstName: 'Ye Min',
    dateOfBirth: _dateOfBirth,
  );

  setUpAll(() => registerFallbackValue(_request()));

  setUp(() {
    repository = MockAuthRepository();
    register = RegisterUseCase(repository);
    when(() => repository.register(any())).thenAnswer((_) async => user);
  });

  group('RegisterUseCase', () {
    test('returns the new member', () async {
      expect(await register(_request()), Success(user));
    });

    test('sends trimmed names to the repository', () async {
      await register(_request(firstName: '  Ye Min ', lastName: ' Phyoe Win '));

      verify(
        () => repository.register(
          _request(lastName: 'Phyoe Win'),
        ),
      ).called(1);
    });

    test('sends a blank last name as no last name', () async {
      await register(_request(lastName: '   '));

      verify(() => repository.register(_request())).called(1);
    });

    test('returns OtpNotVerifiedFailure when the phone skipped OTP', () async {
      when(
        () => repository.register(any()),
      ).thenThrow(const OtpNotVerifiedException());

      expect(
        await register(_request()),
        const Failed<UserEntity>(OtpNotVerifiedFailure()),
      );
    });
  });
}
