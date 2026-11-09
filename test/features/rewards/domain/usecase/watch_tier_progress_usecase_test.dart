import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/member/domain/entity/member_entity.dart';
import 'package:j_donuts/features/member/domain/entity/member_tier.dart';
import 'package:j_donuts/features/member/domain/repository/member_repository.dart';
import 'package:j_donuts/features/rewards/domain/entity/tier_entity.dart';
import 'package:j_donuts/features/rewards/domain/entity/tier_progress_entity.dart';
import 'package:j_donuts/features/rewards/domain/repository/rewards_repository.dart';
import 'package:j_donuts/features/rewards/domain/usecase/watch_tier_progress_usecase.dart';
import 'package:mocktail/mocktail.dart';

class _MockMemberRepository extends Mock implements MemberRepository {}

class _MockRewardsRepository extends Mock implements RewardsRepository {}

const _member = MemberEntity(
  name: 'Hania',
  tier: MemberTier.silver,
  points: 680000,
  notificationCount: 2,
  availableRewards: 3,
);
const _tiers = [TierEntity(tier: MemberTier.silver, minPoints: 0)];

void main() {
  late StreamController<MemberEntity?> member;
  late WatchTierProgressUseCase useCase;

  setUp(() {
    member = StreamController();
    final members = _MockMemberRepository();
    final rewards = _MockRewardsRepository();
    when(members.watchMember).thenAnswer((_) => member.stream);
    when(rewards.watchTiers).thenAnswer((_) => Stream.value(_tiers));
    useCase = WatchTierProgressUseCase(members, rewards);
  });

  tearDown(() => member.close());

  group('WatchTierProgressUseCase', () {
    test('is empty until the member has been seeded', () {
      final progress = useCase(const NoParams());

      member.add(null);

      expect(
        progress,
        emits(
          isA<Success<TierProgressEntity?>>().having(
            (state) => state.data,
            'data',
            isNull,
          ),
        ),
      );
    });

    test('reads points from the same member record as Home', () {
      final points = useCase(
        const NoParams(),
      ).map((state) => state.dataOrNull?.member.points);

      member
        ..add(_member)
        ..add(_member.copyWith(points: 700000));

      expect(points, emitsInOrder([680000, 700000]));
    });
  });
}
