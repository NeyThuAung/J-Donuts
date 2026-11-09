import 'package:injectable/injectable.dart';

import '../../../../config/database_config.dart';
import '../../../../core/database/database.dart';

abstract interface class RewardsLocalDataSource {
  Stream<List<TierRow>> watchTiers();
  Stream<List<ChallengeRow>> watchChallenges();

  /// [key] is one of the DatabaseConfig version keys.
  Future<int?> readVersion(String key);

  // Each save replaces the rows and stores their data version together.
  Future<void> saveTiers(List<TierRow> tiers, int version);
  Future<void> saveChallenges(List<ChallengeRow> challenges, int version);
}

@LazySingleton(as: RewardsLocalDataSource)
class RewardsLocalDataSourceImpl implements RewardsLocalDataSource {
  const RewardsLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  RewardsDao get _rewards => _database.rewardsDao;

  @override
  Stream<List<TierRow>> watchTiers() => _rewards.watchTiers();

  @override
  Stream<List<ChallengeRow>> watchChallenges() => _rewards.watchChallenges();

  @override
  Future<int?> readVersion(String key) async =>
      int.tryParse(await _database.appMetaDao.readValue(key) ?? '');

  @override
  Future<void> saveTiers(List<TierRow> tiers, int version) =>
      _withVersion(DatabaseConfig.tiersVersionKey, version, () {
        return _rewards.replaceTiers(tiers);
      });

  @override
  Future<void> saveChallenges(List<ChallengeRow> challenges, int version) =>
      _withVersion(DatabaseConfig.challengesVersionKey, version, () {
        return _rewards.replaceChallenges(challenges);
      });

  Future<void> _withVersion(
    String key,
    int version,
    Future<void> Function() write,
  ) => _database.transaction(() async {
    await write();
    await _database.appMetaDao.writeValue(key, '$version');
  });
}
