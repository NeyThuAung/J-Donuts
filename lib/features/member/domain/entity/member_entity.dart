import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/image/image_ref.dart';
import 'member_tier.dart';

part 'member_entity.freezed.dart';

/// The one member record Home and Rewards both read.
@freezed
abstract class MemberEntity with _$MemberEntity {
  const factory MemberEntity({
    required String name,
    ImageRef? photo,
    required MemberTier tier,
    required int points,

    /// Null at the top tier.
    MemberTier? nextTier,
    int? pointsToNextTier,
    required int notificationCount,
    required int availableRewards,
  }) = _MemberEntity;
}
