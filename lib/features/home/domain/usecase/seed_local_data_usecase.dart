import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../member/domain/repository/member_repository.dart';
import '../../../product/domain/repository/product_repository.dart';
import '../../../rewards/domain/repository/rewards_repository.dart';
import '../repository/home_repository.dart';

/// Runs before the first frame: writes the bundled data that is newer than
/// the stored data, so Home, Product detail and Rewards work offline.
@lazySingleton
class SeedLocalDataUseCase implements UseCase<void, NoParams> {
  const SeedLocalDataUseCase(
    this._member,
    this._products,
    this._home,
    this._rewards,
  );

  final MemberRepository _member;
  final ProductRepository _products;
  final HomeRepository _home;
  final RewardsRepository _rewards;

  // Products before Home: sections point at products.
  @override
  Future<DataState<void>> call(NoParams param) => guard(() async {
    await _member.seed();
    await _products.seed();
    await _home.seed();
    await _rewards.seed();
  });
}
