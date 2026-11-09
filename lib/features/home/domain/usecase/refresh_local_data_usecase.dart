import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../member/domain/repository/member_repository.dart';
import '../../../product/domain/repository/product_repository.dart';
import '../../../rewards/domain/repository/rewards_repository.dart';
import '../repository/home_repository.dart';

/// Pulls newer data from the API into the local database; the screens
/// update through their watch streams. Stops at the first failure.
@lazySingleton
class RefreshLocalDataUseCase implements UseCase<void, NoParams> {
  const RefreshLocalDataUseCase(
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
    await _member.refresh();
    await _products.refresh();
    await _home.refresh();
    await _rewards.refresh();
  });
}
