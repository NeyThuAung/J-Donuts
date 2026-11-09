import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/member/domain/entity/member_entity.dart';
import 'package:j_donuts/features/member/domain/entity/member_tier.dart';
import 'package:j_donuts/features/rewards/domain/entity/tier_entity.dart';
import 'package:j_donuts/features/rewards/domain/entity/tier_progress_entity.dart';

const _ladder = [
  TierEntity(tier: MemberTier.silver, minPoints: 0),
  TierEntity(tier: MemberTier.gold, minPoints: 680500),
  TierEntity(tier: MemberTier.platinum, minPoints: 900000),
];

TierProgressEntity _progress(
  MemberTier tier,
  int points, {
  List<TierEntity> tiers = _ladder,
}) => TierProgressEntity(
  member: MemberEntity(
    name: 'Hania',
    tier: tier,
    points: points,
    notificationCount: 0,
    availableRewards: 0,
  ),
  tiers: tiers,
);

void main() {
  group('TierProgressEntity.overallProgress', () {
    test('is the points over the top tier start (the brief\'s ¾ ring)', () {
      expect(
        _progress(MemberTier.silver, 680000).overallProgress,
        closeTo(680000 / 900000, 1e-9),
      );
    });

    test('stops at a full ring past the top tier', () {
      expect(_progress(MemberTier.platinum, 2000000).overallProgress, 1);
    });

    test('is full when there is no ladder', () {
      expect(
        _progress(MemberTier.silver, 10, tiers: const []).overallProgress,
        1,
      );
    });
  });

  group('TierProgressEntity.nextTierProgress', () {
    test('measures the way from the current tier to the next', () {
      expect(
        _progress(MemberTier.gold, 790250).nextTierProgress,
        closeTo(0.5, 1e-9),
      );
    });

    test('is full at the top tier', () {
      expect(_progress(MemberTier.platinum, 900000).nextTierProgress, 1);
    });

    test('is full when the member tier is not on the ladder', () {
      expect(
        _progress(
          MemberTier.gold,
          1,
          tiers: const [TierEntity(tier: MemberTier.silver, minPoints: 0)],
        ).nextTierProgress,
        1,
      );
    });

    test('never goes below zero', () {
      expect(_progress(MemberTier.gold, 0).nextTierProgress, 0);
    });
  });
}
