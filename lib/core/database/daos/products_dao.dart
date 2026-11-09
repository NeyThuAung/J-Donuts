import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/products.dart';

part 'products_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {
  ProductsDao(super.attachedDatabase);

  Stream<ProductRow?> watchById(String id) => (select(
    products,
  )..where((product) => product.id.equals(id))).watchSingleOrNull();

  Stream<List<ProductRow>> watchAll() => select(products).watch();

  /// Upserts [rows] and removes products the new list no longer has.
  Future<void> replaceAll(List<ProductRow> rows) => transaction(() async {
    final ids = rows.map((row) => row.id);
    await (delete(products)..where((product) => product.id.isNotIn(ids))).go();
    await batch((batch) => batch.insertAllOnConflictUpdate(products, rows));
  });
}
