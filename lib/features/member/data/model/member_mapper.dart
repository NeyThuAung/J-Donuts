import '../../../../core/database/database.dart';
import '../../../../core/image/image_ref_resolver.dart';
import '../../domain/entity/member_entity.dart';
import '../../domain/entity/member_tier.dart';
import 'member_model.dart';

extension MemberModelMapper on MemberModel {
  MemberRow toRow() => MemberRow(
    id: Members.singleRowId,
    name: name,
    photoUrl: photoUrl,
    tier: tier.name,
    points: points,
    nextTier: nextTier?.name,
    pointsToNextTier: pointsToNextTier,
    notificationCount: notificationCount,
    availableRewards: availableRewards,
  );
}

extension MemberRowMapper on MemberRow {
  MemberEntity toEntity(ImageRefResolver images) {
    final photoUrl = this.photoUrl;
    final nextTier = this.nextTier;
    return MemberEntity(
      name: name,
      photo: photoUrl == null ? null : images.resolve(photoUrl),
      tier: MemberTier.values.byName(tier),
      points: points,
      nextTier: nextTier == null ? null : MemberTier.values.byName(nextTier),
      pointsToNextTier: pointsToNextTier,
      notificationCount: notificationCount,
      availableRewards: availableRewards,
    );
  }
}
