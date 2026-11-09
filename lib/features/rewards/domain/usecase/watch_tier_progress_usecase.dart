import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/sync/combine_latest.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../member/domain/entity/member_entity.dart';
import '../../../member/domain/repository/member_repository.dart';
import '../entity/tier_entity.dart';
import '../entity/tier_progress_entity.dart';
import '../repository/rewards_repository.dart';

/// The member with the tier ladder; Success(null) until the member is seeded.
/// Reads the same member record as Home.
@lazySingleton
class WatchTierProgressUseCase
    implements StreamUseCase<TierProgressEntity?, NoParams> {
  const WatchTierProgressUseCase(this._member, this._rewards);

  final MemberRepository _member;
  final RewardsRepository _rewards;

  @override
  Stream<DataState<TierProgressEntity?>> call(NoParams param) => guardStream(
    combineLatest2(_member.watchMember(), _rewards.watchTiers(), _combine),
  );

  TierProgressEntity? _combine(MemberEntity? member, List<TierEntity> tiers) =>
      member == null ? null : TierProgressEntity(member: member, tiers: tiers);
}
