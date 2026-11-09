import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/challenge_entity.dart';
import '../repository/rewards_repository.dart';

@lazySingleton
class WatchChallengesUseCase
    implements StreamUseCase<List<ChallengeEntity>, NoParams> {
  const WatchChallengesUseCase(this._repository);

  final RewardsRepository _repository;

  @override
  Stream<DataState<List<ChallengeEntity>>> call(NoParams param) =>
      guardStream(_repository.watchChallenges());
}
