import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/member_tier.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

// Shape of /v1/member.json data.
@freezed
abstract class MemberModel with _$MemberModel {
  const factory MemberModel({
    required String name,
    String? photoUrl,
    required MemberTier tier,
    required int points,
    MemberTier? nextTier,
    int? pointsToNextTier,
    required int notificationCount,
    required int availableRewards,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}

MemberModel memberFromJson(Object? json) =>
    MemberModel.fromJson(json! as Map<String, dynamic>);
