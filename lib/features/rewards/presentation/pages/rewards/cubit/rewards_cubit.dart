import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../home/domain/usecase/refresh_local_data_usecase.dart';
import '../../../../domain/entity/challenge_entity.dart';
import '../../../../domain/entity/challenge_tab.dart';
import '../../../../domain/entity/tier_progress_entity.dart';
import '../../../../domain/usecase/watch_challenges_usecase.dart';
import '../../../../domain/usecase/watch_tier_progress_usecase.dart';

part 'rewards_cubit.freezed.dart';
part 'rewards_state.dart';

// Points and challenges each follow their own local-database stream, the
// same data Home reads; refresh only writes to the database.
@injectable
class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit(
    this._watchTierProgress,
    this._watchChallenges,
    this._refresh,
    this._snack,
  ) : super(const RewardsState());

  final WatchTierProgressUseCase _watchTierProgress;
  final WatchChallengesUseCase _watchChallenges;
  final RefreshLocalDataUseCase _refresh;
  final ISnackShower _snack;

  final _subscriptions = <StreamSubscription<Object?>>[];

  void start() {
    const noParams = NoParams();
    _subscriptions.addAll([
      _watchTierProgress(noParams).listen(
        (result) => _update((s) => s.copyWith(progress: result.toSection())),
      ),
      _watchChallenges(noParams).listen(
        (result) => _update((s) => s.copyWith(challenges: result.toSection())),
      ),
    ]);
  }

  void selectTab(ChallengeTab tab) => _update((s) => s.copyWith(tab: tab));

  /// Re-reads both sections after a failure, showing skeletons again; the
  /// selected tab stays.
  Future<void> retry() async {
    await _cancelSubscriptions();
    if (isClosed) return;
    emit(RewardsState(tab: state.tab));
    start();
  }

  /// Pull to refresh: content stays on screen; a failure shows a snack.
  Future<void> refresh() async {
    final result = await _refresh(const NoParams());
    if (isClosed) return;
    result.onError(_snack.error);
  }

  void _update(RewardsState Function(RewardsState state) change) {
    if (!isClosed) emit(change(state));
  }

  Future<void> _cancelSubscriptions() async {
    await Future.wait(_subscriptions.map((sub) => sub.cancel()));
    _subscriptions.clear();
  }

  @override
  Future<void> close() async {
    await _cancelSubscriptions();
    return super.close();
  }
}
