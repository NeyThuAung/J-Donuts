import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/tier_progress_entity.dart';
import '../../cubit/rewards_cubit.dart';
import 'points_ring.dart';
import 'rewards_skeletons.dart';
import 'tier_ladder.dart';

// Tier ladder on the left, points ring on the right.
class RewardsSummary extends StatelessWidget {
  const RewardsSummary({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      RewardsCubit,
      RewardsState,
      SectionData<TierProgressEntity?>
    >(
      selector: (state) => state.progress,
      builder: (context, progress) => SectionSwitcher(
        data: progress,
        skeleton: const RewardsSummarySkeleton(),
        isEmpty: (progress) => progress == null,
        emptyMessage: context.l10n.rewardsMemberEmpty,
        onRetry: context.read<RewardsCubit>().retry,
        builder: (progress) =>
            _Summary(progress: progress!, animation: animation),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.progress, required this.animation});

  final TierProgressEntity progress;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: $styles.grid.pageMargin),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            Expanded(
              child: TierLadder(progress: progress, animation: animation),
            ),
            $styles.insets.sm.toWidthSizedBox,
            PointsRing(
              progress: progress,
              size: PointsRing.sizeFor(constraints.maxWidth),
              animation: animation,
            ),
          ],
        ),
      ),
    );
  }
}
