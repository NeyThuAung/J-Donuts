import '../entity/banner_entity.dart';
import '../entity/home_section_entity.dart';
import '../entity/shop_entity.dart';

abstract interface class HomeRepository {
  Stream<List<BannerEntity>> watchBanners();

  Stream<List<HomeSectionLayout>> watchSectionLayouts();

  Stream<List<ShopEntity>> watchShops();

  /// Writes bundled banners, sections and shops when they are newer.
  /// Products must be seeded first: sections point at them.
  Future<void> seed();

  /// Fetches banners, sections and shops and stores the newer ones.
  /// Products must be refreshed first.
  Future<void> refresh();
}
