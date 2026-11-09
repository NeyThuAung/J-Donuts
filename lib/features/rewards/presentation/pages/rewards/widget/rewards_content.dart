import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../cubit/rewards_cubit.dart';
import 'sub/challenge_list.dart';
import 'sub/challenge_tabs.dart';
import 'sub/rewards_entrance.dart';
import 'sub/rewards_header.dart';
import 'sub/rewards_summary.dart';

// White panel (header, tier ladder, points ring), the tabs on its edge, and
// the challenge cards on grey; pull to refresh keeps the content on screen.
class RewardsContent extends StatelessWidget {
  const RewardsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RewardsCubit, RewardsState, bool>(
      selector: (state) => state.progress is SectionReady,
      builder: (context, isReady) => RewardsEntrance(
        isReady: isReady,
        builder: _build,
      ),
    );
  }

  Widget _build(BuildContext context, Animation<double> animation) {
    final colors = context.appColors;
    final insets = $styles.insets;
    return RefreshIndicator(
      onRefresh: context.read<RewardsCubit>().refresh,
      color: colors.accent,
      edgeOffset: MediaQuery.paddingOf(context).top,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ColoredBox(
              color: colors.surface,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(top: insets.lg, bottom: insets.lg),
                  child: Column(
                    children: [
                      RewardsHeader(animation: animation),
                      insets.xl.toHeightSizedBox,
                      RewardsSummary(animation: animation),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: ChallengeTabs()),
          SliverPadding(
            padding: EdgeInsets.only(
              top: insets.lg,
              bottom:
                  $styles.size.navBarHeight +
                  MediaQuery.paddingOf(context).bottom +
                  insets.xl,
            ),
            sliver: const SliverToBoxAdapter(child: ChallengeList()),
          ),
        ],
      ),
    );
  }
}
