import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../member/domain/entity/member_tier.dart';

part 'tier_entity.freezed.dart';

@freezed
abstract class TierEntity with _$TierEntity {
  const factory TierEntity({
    required MemberTier tier,

    /// Points the tier starts at.
    required int minPoints,
  }) = _TierEntity;
}
