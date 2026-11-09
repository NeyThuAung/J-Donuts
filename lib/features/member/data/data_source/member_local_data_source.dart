import 'package:injectable/injectable.dart';

import '../../../../config/database_config.dart';
import '../../../../core/database/database.dart';

abstract interface class MemberLocalDataSource {
  Stream<MemberRow?> watchMember();
  Future<int?> readVersion();

  /// Saves the member and its data version together.
  Future<void> save(MemberRow member, int version);
}

@LazySingleton(as: MemberLocalDataSource)
class MemberLocalDataSourceImpl implements MemberLocalDataSource {
  const MemberLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<MemberRow?> watchMember() => _database.membersDao.watchMember();

  @override
  Future<int?> readVersion() async => int.tryParse(
    await _database.appMetaDao.readValue(DatabaseConfig.memberVersionKey) ?? '',
  );

  @override
  Future<void> save(MemberRow member, int version) =>
      _database.transaction(() async {
        await _database.membersDao.saveMember(member);
        await _database.appMetaDao.writeValue(
          DatabaseConfig.memberVersionKey,
          '$version',
        );
      });
}
