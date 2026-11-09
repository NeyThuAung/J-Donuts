abstract final class DatabaseConfig {
  // drift_flutter adds the .sqlite extension.
  static const fileName = 'j_donuts';

  // app_meta keys holding the meta.version last written for each resource.
  static const memberVersionKey = 'data_version.member';
  static const productsVersionKey = 'data_version.products';
  static const bannersVersionKey = 'data_version.banners';
  static const sectionsVersionKey = 'data_version.sections';
  static const shopsVersionKey = 'data_version.shops';
}
