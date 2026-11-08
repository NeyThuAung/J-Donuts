import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/config/auth_config.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/core/database/database.dart';
import 'package:j_donuts/features/auth/data/data_source/fake_latency.dart';
import 'package:j_donuts/features/auth/data/data_source/session_local_data_source.dart';
import 'package:j_donuts/features/auth/data/exception/auth_exception.dart';
import 'package:j_donuts/features/auth/data/repository_impl/fake_auth_repository.dart';
import 'package:j_donuts/features/auth/domain/entity/auth_flow.dart';
import 'package:j_donuts/features/auth/domain/entity/registration_request.dart';

const _phone = '+959254135592';
const _wrongCode = '000000';

final _request = RegistrationRequest(
  phone: _phone,
  firstName: 'Ye Min',
  lastName: 'Phyoe Win',
  dateOfBirth: DateTime(1980, 5),
);

class _NoLatency implements FakeLatency {
  @override
  Future<void> call() async {}
}

class _MemorySession implements SessionLocalDataSource {
  String? userId;
  PlatformException? failure;

  @override
  Future<String?> readUserId() async => _orThrow(userId);

  @override
  Future<void> saveUserId(String id) async => userId = _orThrow(id);

  @override
  Future<void> clear() async => userId = _orThrow(null);

  T _orThrow<T>(T value) => failure == null ? value : throw failure!;
}

void main() {
  late AppDatabase database;
  late _MemorySession session;
  late FakeAuthRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    session = _MemorySession();
    repository = FakeAuthRepository(database.usersDao, session, _NoLatency());
  });

  tearDown(() => database.close());

  Future<void> registerMember() async {
    await repository.requestOtp(phone: _phone, flow: AuthFlow.register);
    await repository.verifyOtp(phone: _phone, code: AuthConfig.fakeOtpCode);
    await repository.register(_request);
  }

  group('requestOtp', () {
    test('sends a code to a new number in the register flow', () async {
      await expectLater(
        repository.requestOtp(phone: _phone, flow: AuthFlow.register),
        completes,
      );
    });

    test('rejects a number that never registered in the log-in flow', () async {
      await expectLater(
        repository.requestOtp(phone: _phone, flow: AuthFlow.logIn),
        throwsA(isA<PhoneNotRegisteredException>()),
      );
    });

    test('rejects a registered number in the register flow', () async {
      await registerMember();

      await expectLater(
        repository.requestOtp(phone: _phone, flow: AuthFlow.register),
        throwsA(isA<PhoneAlreadyRegisteredException>()),
      );
    });

    test('sends a code to a registered number in the log-in flow', () async {
      await registerMember();

      await expectLater(
        repository.requestOtp(phone: _phone, flow: AuthFlow.logIn),
        completes,
      );
    });
  });

  group('verifyOtp', () {
    test('rejects any code other than the fake one', () async {
      await expectLater(
        repository.verifyOtp(phone: _phone, code: _wrongCode),
        throwsA(isA<InvalidOtpException>()),
      );
    });

    test('returns null and starts no session for a new number', () async {
      final user = await repository.verifyOtp(
        phone: _phone,
        code: AuthConfig.fakeOtpCode,
      );

      expect(user, isNull);
      expect(session.userId, isNull);
    });

    test('returns the member and starts their session', () async {
      await registerMember();
      await repository.logOut();

      final user = await repository.verifyOtp(
        phone: _phone,
        code: AuthConfig.fakeOtpCode,
      );

      expect(user?.firstName, 'Ye Min');
      expect(session.userId, user?.id);
    });
  });

  group('register', () {
    test('stores the member and starts their session', () async {
      await registerMember();

      final user = await repository.currentUser();
      expect(user?.phone, _phone);
      expect(user?.lastName, 'Phyoe Win');
      expect(user?.dateOfBirth, DateTime(1980, 5));
    });

    test('refuses a number that has not passed OTP', () async {
      await expectLater(
        repository.register(_request),
        throwsA(isA<OtpNotVerifiedException>()),
      );
    });

    test('refuses a number whose OTP failed', () async {
      await expectLater(
        repository.verifyOtp(phone: _phone, code: _wrongCode),
        throwsA(isA<InvalidOtpException>()),
      );

      await expectLater(
        repository.register(_request),
        throwsA(isA<OtpNotVerifiedException>()),
      );
    });

    test('needs a fresh OTP after a new code is requested', () async {
      await repository.verifyOtp(phone: _phone, code: AuthConfig.fakeOtpCode);
      await repository.requestOtp(phone: _phone, flow: AuthFlow.register);

      await expectLater(
        repository.register(_request),
        throwsA(isA<OtpNotVerifiedException>()),
      );
    });
  });

  group('session', () {
    test('has no current user before anyone signs in', () async {
      expect(await repository.currentUser(), isNull);
    });

    test('has no current user after log-out', () async {
      await registerMember();

      await repository.logOut();

      expect(await repository.currentUser(), isNull);
    });

    test('drops a saved session whose member no longer exists', () async {
      session.userId = '42';

      expect(await repository.currentUser(), isNull);
      expect(session.userId, isNull);
    });

    test('turns a secure storage error into a LocalException', () async {
      session.failure = PlatformException(code: 'keychain', message: 'locked');

      await expectLater(
        repository.currentUser(),
        throwsA(isA<LocalException>()),
      );
    });
  });
}
