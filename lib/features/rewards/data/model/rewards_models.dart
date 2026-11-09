import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../member/domain/entity/member_tier.dart';
import '../../domain/entity/challenge_artwork.dart';
import '../../domain/entity/challenge_tab.dart';

part 'rewards_models.freezed.dart';
part 'rewards_models.g.dart';

// Shapes of the items in /v1/tiers.json and challenges.json.
@freezed
abstract class TierModel with _$TierModel {
  const factory TierModel({
    @JsonKey(name: 'id') required MemberTier tier,
    required int minPoints,
  }) = _TierModel;

  factory TierModel.fromJson(Map<String, dynamic> json) =>
      _$TierModelFromJson(json);
}

@freezed
abstract class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    required String id,
    required ChallengeTab tab,
    required String title,
    required int goal,
    required int progress,
    required int rewardPoints,
    required ChallengeArtwork artwork,
    required String imageUrl,
    required int sortOrder,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}

List<TierModel> tiersFromJson(Object? json) =>
    _listFromJson(json, TierModel.fromJson);

List<ChallengeModel> challengesFromJson(Object? json) =>
    _listFromJson(json, ChallengeModel.fromJson);

List<T> _listFromJson<T>(
  Object? json,
  T Function(Map<String, dynamic> json) fromJson,
) => [
  for (final item in json! as List<Object?>)
    fromJson(item! as Map<String, dynamic>),
];
