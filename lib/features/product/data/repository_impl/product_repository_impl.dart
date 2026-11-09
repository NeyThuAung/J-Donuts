import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../../core/database/database.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_local_data_source.dart';
import '../data_source/product_rest_client.dart';
import '../model/product_mapper.dart';
import '../model/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(
    this._local,
    this._remote,
    this._seedReader,
    this._images,
  );

  final ProductLocalDataSource _local;
  final ProductRestClient _remote;
  final SeedAssetReader _seedReader;
  final ImageRefResolver _images;

  @override
  Stream<ProductEntity?> watchProduct(String id) => runLocalStream(
    _local.watchProduct(id).map((row) => row?.toEntity(_images)),
  );

  @override
  Stream<List<ProductEntity>> watchProducts() => runLocalStream(
    _local.watchProducts().map(
      (rows) => [for (final row in rows) row.toEntity(_images)],
    ),
  );

  @override
  Future<void> seed() async {
    final envelope = await runLocal(
      () => _seedReader.read(Assets.seed.v1.products, productsFromJson),
    );
    await _save(envelope);
  }

  @override
  Future<void> refresh() async {
    final envelope = await runRemote(_remote.getProducts);
    await _save(envelope);
  }

  Future<void> _save(ApiEnvelope<List<ProductModel>> envelope) => runLocal(
    () => saveIfNewer(
      envelope,
      storedVersion: _local.readVersion,
      save: (products, version) => _local.save(
        [for (final product in products) product.toRow()],
        version,
      ),
    ),
  );
}
