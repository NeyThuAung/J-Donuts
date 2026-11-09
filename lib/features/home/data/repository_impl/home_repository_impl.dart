import 'package:injectable/injectable.dart';

import '../../../../config/database_config.dart';
import '../../../../core/core.dart';
import '../../../../core/database/database.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entity/banner_entity.dart';
import '../../domain/entity/home_section_entity.dart';
import '../../domain/entity/shop_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_local_data_source.dart';
import '../data_source/home_rest_client.dart';
import '../model/home_mappers.dart';
import '../model/home_models.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(
    this._local,
    this._remote,
    this._seedReader,
    this._images,
  );

  final HomeLocalDataSource _local;
  final HomeRestClient _remote;
  final SeedAssetReader _seedReader;
  final ImageRefResolver _images;

  @override
  Stream<List<BannerEntity>> watchBanners() => runLocalStream(
    _local.watchBanners().map(
      (rows) => [for (final row in rows) row.toEntity(_images)],
    ),
  );

  @override
  Stream<List<HomeSectionLayout>> watchSectionLayouts() => runLocalStream(
    _local.watchSections().map(
      (rows) => [for (final row in rows) row.toLayout()],
    ),
  );

  @override
  Stream<List<ShopEntity>> watchShops() => runLocalStream(
    _local.watchShops().map(
      (rows) => [for (final row in rows) row.toEntity(_images)],
    ),
  );

  @override
  Future<void> seed() async {
    final seed = Assets.seed.v1;
    await _saveBanners(await _readSeed(seed.banners, bannersFromJson));
    await _saveShops(await _readSeed(seed.shops, shopsFromJson));
    await _saveSections(await _readSeed(seed.sections, sectionsFromJson));
  }

  @override
  Future<void> refresh() async {
    await _saveBanners(await runRemote(_remote.getBanners));
    await _saveShops(await runRemote(_remote.getShops));
    await _saveSections(await runRemote(_remote.getSections));
  }

  Future<ApiEnvelope<T>> _readSeed<T>(
    String path,
    T Function(Object? json) fromJson,
  ) => runLocal(() => _seedReader.read(path, fromJson));

  Future<void> _saveBanners(ApiEnvelope<List<BannerModel>> envelope) =>
      _saveIfNewer(DatabaseConfig.bannersVersionKey, envelope, (data, v) {
        return _local.saveBanners([for (final b in data) b.toRow()], v);
      });

  Future<void> _saveShops(ApiEnvelope<List<ShopModel>> envelope) =>
      _saveIfNewer(DatabaseConfig.shopsVersionKey, envelope, (data, v) {
        return _local.saveShops([for (final s in data) s.toRow()], v);
      });

  Future<void> _saveSections(ApiEnvelope<List<SectionModel>> envelope) =>
      _saveIfNewer(DatabaseConfig.sectionsVersionKey, envelope, (data, v) {
        return _local.saveSections(
          [for (final section in data) section.toRow()],
          [for (final section in data) ...section.toLinks()],
          v,
        );
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
