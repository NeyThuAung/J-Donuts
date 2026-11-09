import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/shop_entity.dart';
import '../repository/home_repository.dart';

@lazySingleton
class WatchShopsUseCase implements StreamUseCase<List<ShopEntity>, NoParams> {
  const WatchShopsUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Stream<DataState<List<ShopEntity>>> call(NoParams param) =>
      guardStream(_repository.watchShops());
}
