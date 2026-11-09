import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../member/domain/entity/member_entity.dart';
import 'tier_entity.dart';

part 'tier_progress_entity.freezed.dart';

/// The member's points measured against the tier ladder.
@freezed
abstract class TierProgressEntity with _$TierProgressEntity {
  const factory TierProgressEntity({
    required MemberEntity member,

    /// Lowest tier first.
    required List<TierEntity> tiers,
  }) = _TierProgressEntity;

  const TierProgressEntity._();

  /// Points over the top tier's start, 0 to 1; drives the points ring.
  double get overallProgress {
    final top = tiers.isEmpty ? 0 : tiers.last.minPoints;
    return top <= 0 ? 1 : (member.points / top).clamp(0.0, 1.0);
  }

  /// Way from the current tier's start to the next tier's, 0 to 1; 1 at the
  /// top tier. Drives the ladder line.
  double get nextTierProgress {
    final index = tiers.indexWhere((tier) => tier.tier == member.tier);
    if (index < 0 || index == tiers.length - 1) return 1;
    final start = tiers[index].minPoints;
    final span = tiers[index + 1].minPoints - start;
    return span <= 0 ? 1 : ((member.points - start) / span).clamp(0.0, 1.0);
  }
}
