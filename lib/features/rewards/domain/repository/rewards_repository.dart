import '../entity/challenge_entity.dart';
import '../entity/tier_entity.dart';

abstract interface class RewardsRepository {
  /// Lowest tier first.
  Stream<List<TierEntity>> watchTiers();

  /// Both tabs, in display order.
  Stream<List<ChallengeEntity>> watchChallenges();

  /// Writes the bundled tiers and challenges when they are newer.
  Future<void> seed();

  /// Fetches tiers and challenges and stores the newer ones.
  Future<void> refresh();
}
