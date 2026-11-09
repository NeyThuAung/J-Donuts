import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/banners.dart';
import '../tables/sections.dart';
import '../tables/shops.dart';

part 'home_dao.g.dart';

typedef SectionWithProductIds = ({SectionRow section, List<String> productIds});

@DriftAccessor(tables: [Banners, Sections, SectionProducts, Shops])
class HomeDao extends DatabaseAccessor<AppDatabase> with _$HomeDaoMixin {
  HomeDao(super.attachedDatabase);

  Stream<List<BannerRow>> watchBanners() => (select(
    banners,
  )..orderBy([(banner) => OrderingTerm(expression: banner.sortOrder)])).watch();

  Stream<List<ShopRow>> watchShops() => (select(
    shops,
  )..orderBy([(shop) => OrderingTerm(expression: shop.sortOrder)])).watch();

  /// Sections in order with their product ids in order; a section without
  /// products is kept with an empty list.
  Stream<List<SectionWithProductIds>> watchSections() {
    final query =
        select(sections).join([
          leftOuterJoin(
            sectionProducts,
            sectionProducts.sectionId.equalsExp(sections.id),
          ),
        ])..orderBy([
          OrderingTerm(expression: sections.sortOrder),
          OrderingTerm(expression: sectionProducts.sortOrder),
        ]);
    return query.watch().map(_groupBySection);
  }

  Future<void> replaceBanners(List<BannerRow> rows) => transaction(() async {
    final ids = rows.map((row) => row.id);
    await (delete(banners)..where((banner) => banner.id.isNotIn(ids))).go();
    await batch((batch) => batch.insertAllOnConflictUpdate(banners, rows));
  });

  Future<void> replaceShops(List<ShopRow> rows) => transaction(() async {
    final ids = rows.map((row) => row.id);
    await (delete(shops)..where((shop) => shop.id.isNotIn(ids))).go();
    await batch((batch) => batch.insertAllOnConflictUpdate(shops, rows));
  });

  /// Product ids in [links] must already exist in products.
  Future<void> replaceSections(
    List<SectionRow> rows,
    List<SectionProductRow> links,
  ) => transaction(() async {
    final ids = rows.map((row) => row.id);
    await delete(sectionProducts).go();
    await (delete(sections)..where((section) => section.id.isNotIn(ids))).go();
    await batch((batch) {
      batch
        ..insertAllOnConflictUpdate(sections, rows)
        ..insertAll(sectionProducts, links);
    });
  });

  List<SectionWithProductIds> _groupBySection(List<TypedResult> rows) {
    final grouped = <String, SectionWithProductIds>{};
    for (final row in rows) {
      final section = row.readTable(sections);
      final entry = grouped.putIfAbsent(
        section.id,
        () => (section: section, productIds: <String>[]),
      );
      final link = row.readTableOrNull(sectionProducts);
      if (link != null) entry.productIds.add(link.productId);
    }
    return grouped.values.toList();
  }
}
