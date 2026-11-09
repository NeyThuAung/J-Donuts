import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/challenge_entity.dart';
import '../../../../../domain/entity/challenge_tab.dart';
import '../../cubit/rewards_cubit.dart';
import 'challenge_card.dart';
import 'rewards_entrance.dart';
import 'rewards_skeletons.dart';

// The selected tab's cards, with their own skeleton, empty and error states.
// Switching tabs fades the old list out and the new one up; cards enter
// staggered on every visit and every switch.
class ChallengeList extends StatelessWidget {
  const ChallengeList({super.key});

  // How far the incoming list rises, as a share of its height.
  static const _switchRise = Offset(0, 0.04);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsCubit, RewardsState>(
      buildWhen: (previous, current) =>
          previous.challenges != current.challenges ||
          previous.tab != current.tab,
      builder: (context, state) => AppAnimatedSize(
        duration: AppMotion.tabSwitch,
        alignment: Alignment.topCenter,
        child: AnimatedSwitcher(
          duration: context.motion(AppMotion.tabSwitch),
          switchInCurve: AppMotion.standard,
          switchOutCurve: AppMotion.standard,
          layoutBuilder: _topAligned,
          transitionBuilder: _fadeUp,
          child: KeyedSubtree(
            key: ValueKey(state.tab),
            child: _TabContent(state: state),
          ),
        ),
      ),
    );
  }

  static Widget _topAligned(Widget? current, List<Widget> previous) => Stack(
    alignment: Alignment.topCenter,
    children: [...previous, ?current],
  );

  static Widget _fadeUp(Widget child, Animation<double> animation) =>
      FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: animation.drive(
            Tween(begin: _switchRise, end: Offset.zero),
          ),
          child: child,
        ),
      );
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.state});

  final RewardsState state;

  @override
  Widget build(BuildContext context) {
    return SectionSwitcher(
      data: state.visibleChallenges,
      skeleton: const ChallengeListSkeleton(),
      isEmpty: (challenges) => challenges.isEmpty,
      emptyMessage: _emptyMessage(context.l10n, state.tab),
      onRetry: context.read<RewardsCubit>().retry,
      builder: (challenges) => RewardsEntrance(
        isReady: true,
        duration: AppMotion.rewardsCards,
        builder: (context, animation) =>
            _Cards(challenges: challenges, animation: animation),
      ),
    );
  }

  String _emptyMessage(AppLocalizations l10n, ChallengeTab tab) =>
      switch (tab) {
        ChallengeTab.earn => l10n.rewardsChallengesEmpty,
        ChallengeTab.gift => l10n.rewardsGiftEmpty,
      };
}

class _Cards extends StatelessWidget {
  const _Cards({required this.challenges, required this.animation});

  final List<ChallengeEntity> challenges;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
      child: Column(
        children: [
          for (final (index, challenge) in challenges.indexed) ...[
            if (index > 0) $styles.grid.cardGap.toHeightSizedBox,
            EntranceItem(
              key: ValueKey(challenge.id),
              animation: animation,
              index: index,
              child: ChallengeCard(
                challenge: challenge,
                art: animation.drive(
                  CurveTween(curve: rewardsArtInterval(index)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
