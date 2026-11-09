import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/image/image_ref.dart';
import 'challenge_artwork.dart';
import 'challenge_tab.dart';

part 'challenge_entity.freezed.dart';

@freezed
abstract class ChallengeEntity with _$ChallengeEntity {
  const factory ChallengeEntity({
    required String id,
    required ChallengeTab tab,
    required String title,
    required int goal,
    required int progress,
    required int rewardPoints,
    required ChallengeArtwork artwork,
    required ImageRef image,
  }) = _ChallengeEntity;

  const ChallengeEntity._();

  /// Earn is active only then.
  bool get isComplete => progress >= goal;

  /// 0 to 1, for the artwork.
  double get fraction => goal <= 0 ? 1 : (progress / goal).clamp(0.0, 1.0);
}
