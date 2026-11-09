import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/rewards/domain/entity/challenge_artwork.dart';
import 'package:j_donuts/features/rewards/domain/entity/challenge_entity.dart';
import 'package:j_donuts/features/rewards/domain/entity/challenge_tab.dart';

ChallengeEntity _challenge(int progress, int goal) => ChallengeEntity(
  id: 'c',
  tab: ChallengeTab.earn,
  title: 'Eat 4 Coco donuts',
  goal: goal,
  progress: progress,
  rewardPoints: 100,
  artwork: ChallengeArtwork.donutQuarters,
  image: const AssetImageRef('donut.png'),
);

void main() {
  group('ChallengeEntity', () {
    test('is complete at 4/4, which turns Earn on', () {
      expect(_challenge(4, 4).isComplete, isTrue);
      expect(_challenge(1, 4).isComplete, isFalse);
    });

    test('draws the art from the share done (coffee 9/12)', () {
      expect(_challenge(1, 4).fraction, 0.25);
      expect(_challenge(9, 12).fraction, 0.75);
    });

    test('keeps the share between 0 and 1', () {
      expect(_challenge(6, 4).fraction, 1);
      expect(_challenge(-1, 4).fraction, 0);
    });

    test('treats a goal of zero as done instead of dividing by zero', () {
      expect(_challenge(0, 0).fraction, 1);
    });
  });
}
