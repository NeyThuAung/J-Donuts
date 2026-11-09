import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

/// Param is the product id; Success(null) means no such product.
@lazySingleton
class WatchProductUseCase implements StreamUseCase<ProductEntity?, String> {
  const WatchProductUseCase(this._repository);

  final ProductRepository _repository;

  @override
  Stream<DataState<ProductEntity?>> call(String productId) =>
      guardStream(_repository.watchProduct(productId));
}
