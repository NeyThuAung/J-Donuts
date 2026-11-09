import '../../../../core/database/database.dart';
import '../../../../core/image/image_ref_resolver.dart';
import '../../../member/domain/entity/member_tier.dart';
import '../../domain/entity/challenge_artwork.dart';
import '../../domain/entity/challenge_entity.dart';
import '../../domain/entity/challenge_tab.dart';
import '../../domain/entity/tier_entity.dart';
import 'rewards_models.dart';

extension TierModelMapper on TierModel {
  TierRow toRow() => TierRow(id: tier.name, minPoints: minPoints);
}

extension TierRowMapper on TierRow {
  TierEntity toEntity() =>
      TierEntity(tier: MemberTier.values.byName(id), minPoints: minPoints);
}

extension ChallengeModelMapper on ChallengeModel {
  ChallengeRow toRow() => ChallengeRow(
    id: id,
    tab: tab.name,
    title: title,
    goal: goal,
    progress: progress,
    rewardPoints: rewardPoints,
    artwork: artwork.name,
    imageUrl: imageUrl,
    sortOrder: sortOrder,
  );
}

extension ChallengeRowMapper on ChallengeRow {
  ChallengeEntity toEntity(ImageRefResolver images) => ChallengeEntity(
    id: id,
    tab: ChallengeTab.values.byName(tab),
    title: title,
    goal: goal,
    progress: progress,
    rewardPoints: rewardPoints,
    artwork: ChallengeArtwork.values.byName(artwork),
    image: images.resolve(imageUrl),
  );
}
