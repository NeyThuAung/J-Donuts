import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/secure_storage_config.dart';

abstract interface class SessionLocalDataSource {
  Future<String?> readUserId();
  Future<void> saveUserId(String userId);
  Future<void> clear();
}

@LazySingleton(as: SessionLocalDataSource)
class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  const SessionLocalDataSourceImpl(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readUserId() =>
      _storage.read(key: SecureStorageConfig.sessionUserIdKey);

  @override
  Future<void> saveUserId(String userId) => _storage.write(
    key: SecureStorageConfig.sessionUserIdKey,
    value: userId,
  );

  @override
  Future<void> clear() =>
      _storage.delete(key: SecureStorageConfig.sessionUserIdKey);
}
