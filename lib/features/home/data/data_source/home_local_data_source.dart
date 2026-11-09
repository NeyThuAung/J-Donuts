import 'package:injectable/injectable.dart';

import '../../../../config/database_config.dart';
import '../../../../core/database/database.dart';

abstract interface class HomeLocalDataSource {
  Stream<List<BannerRow>> watchBanners();
  Stream<List<SectionWithProductIds>> watchSections();
  Stream<List<ShopRow>> watchShops();

  /// [key] is one of the DatabaseConfig version keys.
  Future<int?> readVersion(String key);

  // Each save replaces the rows and stores their data version together.
  Future<void> saveBanners(List<BannerRow> banners, int version);
  Future<void> saveShops(List<ShopRow> shops, int version);
  Future<void> saveSections(
    List<SectionRow> sections,
    List<SectionProductRow> links,
    int version,
  );
}

@LazySingleton(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  HomeDao get _home => _database.homeDao;

  @override
  Stream<List<BannerRow>> watchBanners() => _home.watchBanners();

  @override
  Stream<List<SectionWithProductIds>> watchSections() => _home.watchSections();

  @override
  Stream<List<ShopRow>> watchShops() => _home.watchShops();

  @override
  Future<int?> readVersion(String key) async =>
      int.tryParse(await _database.appMetaDao.readValue(key) ?? '');

  @override
  Future<void> saveBanners(List<BannerRow> banners, int version) =>
      _withVersion(DatabaseConfig.bannersVersionKey, version, () {
        return _home.replaceBanners(banners);
      });

  @override
  Future<void> saveShops(List<ShopRow> shops, int version) =>
      _withVersion(DatabaseConfig.shopsVersionKey, version, () {
        return _home.replaceShops(shops);
      });

  @override
  Future<void> saveSections(
    List<SectionRow> sections,
    List<SectionProductRow> links,
    int version,
  ) => _withVersion(DatabaseConfig.sectionsVersionKey, version, () {
    return _home.replaceSections(sections, links);
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
