import 'package:drift/drift.dart' show Value;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/auth_config.dart';
import '../../../../core/core.dart';
import '../../../../core/database/database.dart';
import '../../domain/entity/auth_flow.dart';
import '../../domain/entity/registration_request.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/fake_latency.dart';
import '../data_source/session_local_data_source.dart';
import '../exception/auth_exception.dart';
import '../model/user_row_mapper.dart';

// Fake backend: waits like a network call, keeps members in Drift and
// accepts only AuthConfig.fakeOtpCode.
@LazySingleton(as: AuthRepository)
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository(this._users, this._session, this._latency);

  final UsersDao _users;
  final SessionLocalDataSource _session;
  final FakeLatency _latency;

  // New numbers that passed OTP and may now register.
  final _verifiedPhones = <String>{};

  @override
  Future<void> requestOtp({
    required String phone,
    required AuthFlow flow,
  }) async {
    await _latency();
    final isRegistered = await _findByPhone(phone) != null;
    if (flow == AuthFlow.logIn && !isRegistered) {
      throw const PhoneNotRegisteredException();
    }
    if (flow == AuthFlow.register && isRegistered) {
      throw const PhoneAlreadyRegisteredException();
    }
    _verifiedPhones.remove(phone);
  }

  @override
  Future<UserEntity?> verifyOtp({
    required String phone,
    required String code,
  }) async {
    await _latency();
    if (code != AuthConfig.fakeOtpCode) throw const InvalidOtpException();
    final user = await _findByPhone(phone);
    if (user == null) {
      _verifiedPhones.add(phone);
      return null;
    }
    return _startSession(user);
  }

  @override
  Future<UserEntity> register(RegistrationRequest request) async {
    await _latency();
    if (!_verifiedPhones.contains(request.phone)) {
      throw const OtpNotVerifiedException();
    }
    final id = await runLocal(() => _users.insertUser(_toRow(request)));
    _verifiedPhones.remove(request.phone);
    final user = await runLocal(() => _users.findById(id));
    return _startSession(user!);
  }

  @override
  Future<UserEntity?> currentUser() async {
    final userId = int.tryParse(await _secure(_session.readUserId) ?? '');
    if (userId == null) return null;
    final user = await runLocal(() => _users.findById(userId));
    // The member is gone (e.g. app data cleared): drop the stale session.
    if (user == null) await logOut();
    return user?.toEntity();
  }

  @override
  Future<void> logOut() => _secure(_session.clear);

  Future<UserRow?> _findByPhone(String phone) =>
      runLocal(() => _users.findByPhone(phone));

  Future<UserEntity> _startSession(UserRow user) async {
    await _secure(() => _session.saveUserId('${user.id}'));
    return user.toEntity();
  }

  UsersCompanion _toRow(RegistrationRequest request) => UsersCompanion.insert(
    phone: request.phone,
    firstName: request.firstName,
    lastName: Value(request.lastName),
    dateOfBirth: request.dateOfBirth,
  );

  // Keychain / Keystore errors arrive as PlatformException.
  Future<T> _secure<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on PlatformException catch (error, stackTrace) {
      Error.throwWithStackTrace(
        LocalException(error.message ?? error.code, error.code),
        stackTrace,
      );
    }
  }
}
