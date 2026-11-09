import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/sync/combine_latest.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../product/domain/entity/product_entity.dart';
import '../../../product/domain/repository/product_repository.dart';
import '../entity/home_section_entity.dart';
import '../repository/home_repository.dart';

/// Sections with their products, in order; updates when either changes.
/// Ids without a product are skipped.
@lazySingleton
class WatchHomeSectionsUseCase
    implements StreamUseCase<List<HomeSectionEntity>, NoParams> {
  const WatchHomeSectionsUseCase(this._home, this._products);

  final HomeRepository _home;
  final ProductRepository _products;

  @override
  Stream<DataState<List<HomeSectionEntity>>> call(NoParams param) =>
      guardStream(
        combineLatest2(
          _home.watchSectionLayouts(),
          _products.watchProducts(),
          _withProducts,
        ),
      );

  List<HomeSectionEntity> _withProducts(
    List<HomeSectionLayout> layouts,
    List<ProductEntity> products,
  ) {
    final byId = {for (final product in products) product.id: product};
    return [
      for (final layout in layouts)
        HomeSectionEntity(
          id: layout.id,
          type: layout.type,
          products: [
            for (final id in layout.productIds) ?byId[id],
          ],
        ),
    ];
  }
}
