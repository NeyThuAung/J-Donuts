part of 'rewards_cubit.dart';

@freezed
abstract class RewardsState with _$RewardsState {
  const factory RewardsState({
    @Default(SectionLoading<TierProgressEntity?>())
    SectionData<TierProgressEntity?> progress,
    @Default(SectionLoading<List<ChallengeEntity>>())
    SectionData<List<ChallengeEntity>> challenges,
    @Default(ChallengeTab.earn) ChallengeTab tab,
  }) = _RewardsState;

  const RewardsState._();

  SectionData<List<ChallengeEntity>> get visibleChallenges =>
      switch (challenges) {
        SectionReady(:final data) => SectionData.ready([
          for (final challenge in data)
            if (challenge.tab == tab) challenge,
        ]),
        final other => other,
      };
}
