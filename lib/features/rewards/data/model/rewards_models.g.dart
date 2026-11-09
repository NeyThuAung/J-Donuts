// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TierModel _$TierModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TierModel', json, ($checkedConvert) {
      final val = _TierModel(
        tier: $checkedConvert('id', (v) => $enumDecode(_$MemberTierEnumMap, v)),
        minPoints: $checkedConvert('minPoints', (v) => (v as num).toInt()),
      );
      return val;
    }, fieldKeyMap: const {'tier': 'id'});

Map<String, dynamic> _$TierModelToJson(_TierModel instance) =>
    <String, dynamic>{
      'id': _$MemberTierEnumMap[instance.tier]!,
      'minPoints': instance.minPoints,
    };

const _$MemberTierEnumMap = {
  MemberTier.silver: 'silver',
  MemberTier.gold: 'gold',
  MemberTier.platinum: 'platinum',
};

_ChallengeModel _$ChallengeModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ChallengeModel', json, ($checkedConvert) {
  final val = _ChallengeModel(
    id: $checkedConvert('id', (v) => v as String),
    tab: $checkedConvert('tab', (v) => $enumDecode(_$ChallengeTabEnumMap, v)),
    title: $checkedConvert('title', (v) => v as String),
    goal: $checkedConvert('goal', (v) => (v as num).toInt()),
    progress: $checkedConvert('progress', (v) => (v as num).toInt()),
    rewardPoints: $checkedConvert('rewardPoints', (v) => (v as num).toInt()),
    artwork: $checkedConvert(
      'artwork',
      (v) => $enumDecode(_$ChallengeArtworkEnumMap, v),
    ),
    imageUrl: $checkedConvert('imageUrl', (v) => v as String),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$ChallengeModelToJson(_ChallengeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tab': _$ChallengeTabEnumMap[instance.tab]!,
      'title': instance.title,
      'goal': instance.goal,
      'progress': instance.progress,
      'rewardPoints': instance.rewardPoints,
      'artwork': _$ChallengeArtworkEnumMap[instance.artwork]!,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
    };

const _$ChallengeTabEnumMap = {
  ChallengeTab.earn: 'earn',
  ChallengeTab.gift: 'gift',
};

const _$ChallengeArtworkEnumMap = {
  ChallengeArtwork.donutQuarters: 'donutQuarters',
  ChallengeArtwork.arc: 'arc',
};
