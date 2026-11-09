// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_MemberModel',
  json,
  ($checkedConvert) {
    final val = _MemberModel(
      name: $checkedConvert('name', (v) => v as String),
      photoUrl: $checkedConvert('photoUrl', (v) => v as String?),
      tier: $checkedConvert('tier', (v) => $enumDecode(_$MemberTierEnumMap, v)),
      points: $checkedConvert('points', (v) => (v as num).toInt()),
      nextTier: $checkedConvert(
        'nextTier',
        (v) => $enumDecodeNullable(_$MemberTierEnumMap, v),
      ),
      pointsToNextTier: $checkedConvert(
        'pointsToNextTier',
        (v) => (v as num?)?.toInt(),
      ),
      notificationCount: $checkedConvert(
        'notificationCount',
        (v) => (v as num).toInt(),
      ),
      availableRewards: $checkedConvert(
        'availableRewards',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$MemberModelToJson(_MemberModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'tier': _$MemberTierEnumMap[instance.tier]!,
      'points': instance.points,
      'nextTier': _$MemberTierEnumMap[instance.nextTier],
      'pointsToNextTier': instance.pointsToNextTier,
      'notificationCount': instance.notificationCount,
      'availableRewards': instance.availableRewards,
    };

const _$MemberTierEnumMap = {
  MemberTier.silver: 'silver',
  MemberTier.gold: 'gold',
  MemberTier.platinum: 'platinum',
};
