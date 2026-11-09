import '../entity/product_entity.dart';

abstract interface class ProductRepository {
  /// Emits null when no product has [id].
  Stream<ProductEntity?> watchProduct(String id);

  Stream<List<ProductEntity>> watchProducts();

  /// Writes the bundled products when they are newer than what is stored.
  Future<void> seed();

  /// Fetches products from the API and stores them when they are newer.
  Future<void> refresh();
}
