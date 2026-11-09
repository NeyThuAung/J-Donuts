import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/home/domain/usecase/refresh_local_data_usecase.dart';
import 'package:j_donuts/features/rewards/domain/entity/challenge_artwork.dart';
import 'package:j_donuts/features/rewards/domain/entity/challenge_entity.dart';
import 'package:j_donuts/features/rewards/domain/entity/challenge_tab.dart';
import 'package:j_donuts/features/rewards/domain/entity/tier_progress_entity.dart';
import 'package:j_donuts/features/rewards/domain/usecase/watch_challenges_usecase.dart';
import 'package:j_donuts/features/rewards/domain/usecase/watch_tier_progress_usecase.dart';
import 'package:j_donuts/features/rewards/presentation/pages/rewards/cubit/rewards_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockWatchTierProgress extends Mock implements WatchTierProgressUseCase {}

class _MockWatchChallenges extends Mock implements WatchChallengesUseCase {}

class _MockRefresh extends Mock implements RefreshLocalDataUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

const _noParams = NoParams();

ChallengeEntity _challenge(String id, ChallengeTab tab) => ChallengeEntity(
  id: id,
  tab: tab,
  title: id,
  goal: 4,
  progress: 1,
  rewardPoints: 100,
  artwork: ChallengeArtwork.donutQuarters,
  image: const AssetImageRef('donut.png'),
);

List<String>? _visibleIds(RewardsState state) =>
    switch (state.visibleChallenges) {
      SectionReady(:final data) => [for (final c in data) c.id],
      _ => null,
    };

void main() {
  late StreamController<DataState<List<ChallengeEntity>>> challenges;
  late _MockWatchChallenges watchChallenges;
  late _MockRefresh refresh;
  late _MockSnackShower snack;
  late RewardsCubit cubit;

  setUpAll(() => registerFallbackValue(const CacheFailure()));

  setUp(() {
    challenges = StreamController.broadcast();
    final watchTierProgress = _MockWatchTierProgress();
    watchChallenges = _MockWatchChallenges();
    refresh = _MockRefresh();
    snack = _MockSnackShower();
    when(() => watchTierProgress(_noParams)).thenAnswer(
      (_) => Stream.value(const Success<TierProgressEntity?>(null)),
    );
    when(
      () => watchChallenges(_noParams),
    ).thenAnswer((_) => challenges.stream);
    cubit = RewardsCubit(watchTierProgress, watchChallenges, refresh, snack)
      ..start();
  });

  tearDown(() async {
    await cubit.close();
    await challenges.close();
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  group('RewardsCubit', () {
    test('opens on the Eat more earn more tab', () {
      expect(cubit.state.tab, ChallengeTab.earn);
    });

    test('shows only the selected tab\'s challenges', () async {
      challenges.add(
        Success([
          _challenge('coco', ChallengeTab.earn),
          _challenge('gift', ChallengeTab.gift),
        ]),
      );
      await settle();

      expect(_visibleIds(cubit.state), ['coco']);
      cubit.selectTab(ChallengeTab.gift);
      expect(_visibleIds(cubit.state), ['gift']);
    });

    test('shows an empty Gift tab when it has no challenges', () async {
      challenges.add(Success([_challenge('coco', ChallengeTab.earn)]));
      await settle();

      cubit.selectTab(ChallengeTab.gift);

      expect(_visibleIds(cubit.state), isEmpty);
    });

    test('keeps the challenge list failure on both tabs', () async {
      challenges.add(const Failed(CacheFailure()));
      await settle();

      expect(
        cubit.state.visibleChallenges,
        isA<SectionFailed<List<ChallengeEntity>>>(),
      );
      expect(cubit.state.progress, isA<SectionReady<TierProgressEntity?>>());
    });

    test('retry keeps the selected tab', () async {
      cubit.selectTab(ChallengeTab.gift);

      await cubit.retry();

      expect(cubit.state.tab, ChallengeTab.gift);
      verify(() => watchChallenges(_noParams)).called(2);
    });

    test('pull to refresh reports a failure in a snack', () async {
      when(
        () => refresh(_noParams),
      ).thenAnswer((_) async => const Failed(ConnectionFailure()));

      await cubit.refresh();

      verify(() => snack.error(any(that: isA<ConnectionFailure>()))).called(1);
    });
  });
}
