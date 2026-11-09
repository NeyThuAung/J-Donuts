import 'package:injectable/injectable.dart';

import '../../../../config/database_config.dart';
import '../../../../core/core.dart';
import '../../../../core/database/database.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entity/challenge_entity.dart';
import '../../domain/entity/tier_entity.dart';
import '../../domain/repository/rewards_repository.dart';
import '../data_source/rewards_local_data_source.dart';
import '../data_source/rewards_rest_client.dart';
import '../model/rewards_mappers.dart';
import '../model/rewards_models.dart';

@LazySingleton(as: RewardsRepository)
class RewardsRepositoryImpl implements RewardsRepository {
  const RewardsRepositoryImpl(
    this._local,
    this._remote,
    this._seedReader,
    this._images,
  );

  final RewardsLocalDataSource _local;
  final RewardsRestClient _remote;
  final SeedAssetReader _seedReader;
  final ImageRefResolver _images;

  @override
  Stream<List<TierEntity>> watchTiers() => runLocalStream(
    _local.watchTiers().map((rows) => [for (final row in rows) row.toEntity()]),
  );

  @override
  Stream<List<ChallengeEntity>> watchChallenges() => runLocalStream(
    _local.watchChallenges().map(
      (rows) => [for (final row in rows) row.toEntity(_images)],
    ),
  );

  @override
  Future<void> seed() async {
    final seed = Assets.seed.v1;
    await _saveTiers(await _readSeed(seed.tiers, tiersFromJson));
    await _saveChallenges(await _readSeed(seed.challenges, challengesFromJson));
  }

  @override
  Future<void> refresh() async {
    await _saveTiers(await runRemote(_remote.getTiers));
    await _saveChallenges(await runRemote(_remote.getChallenges));
  }

  Future<ApiEnvelope<T>> _readSeed<T>(
    String path,
    T Function(Object? json) fromJson,
  ) => runLocal(() => _seedReader.read(path, fromJson));

  Future<void> _saveTiers(ApiEnvelope<List<TierModel>> envelope) =>
      _saveIfNewer(DatabaseConfig.tiersVersionKey, envelope, (data, v) {
        return _local.saveTiers([for (final tier in data) tier.toRow()], v);
      });

  Future<void> _saveChallenges(ApiEnvelope<List<ChallengeModel>> envelope) =>
      _saveIfNewer(DatabaseConfig.challengesVersionKey, envelope, (data, v) {
        return _local.saveChallenges([for (final c in data) c.toRow()], v);
      });

  Future<void> _saveIfNewer<T>(
    String versionKey,
    ApiEnvelope<T> envelope,
    Future<void> Function(T data, int version) save,
  ) => runLocal(
    () => saveIfNewer(
      envelope,
      storedVersion: () => _local.readVersion(versionKey),
      save: save,
    ),
  );
}
