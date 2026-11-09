import 'package:injectable/injectable.dart';

import '../../../../config/database_config.dart';
import '../../../../core/database/database.dart';

abstract interface class ProductLocalDataSource {
  Stream<ProductRow?> watchProduct(String id);
  Stream<List<ProductRow>> watchProducts();
  Future<int?> readVersion();

  /// Replaces the products and saves their data version together.
  Future<void> save(List<ProductRow> products, int version);
}

@LazySingleton(as: ProductLocalDataSource)
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  const ProductLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<ProductRow?> watchProduct(String id) =>
      _database.productsDao.watchById(id);

  @override
  Stream<List<ProductRow>> watchProducts() => _database.productsDao.watchAll();

  @override
  Future<int?> readVersion() async => int.tryParse(
    await _database.appMetaDao.readValue(DatabaseConfig.productsVersionKey) ??
        '',
  );

  @override
  Future<void> save(List<ProductRow> products, int version) =>
      _database.transaction(() async {
        await _database.productsDao.replaceAll(products);
        await _database.appMetaDao.writeValue(
          DatabaseConfig.productsVersionKey,
          '$version',
        );
      });
}
