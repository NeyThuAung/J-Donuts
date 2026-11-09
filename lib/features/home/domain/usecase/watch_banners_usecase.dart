import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/banner_entity.dart';
import '../repository/home_repository.dart';

@lazySingleton
class WatchBannersUseCase
    implements StreamUseCase<List<BannerEntity>, NoParams> {
  const WatchBannersUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Stream<DataState<List<BannerEntity>>> call(NoParams param) =>
      guardStream(_repository.watchBanners());
}
