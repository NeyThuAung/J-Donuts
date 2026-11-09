import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../cubit/rewards_cubit.dart';

// Title and the orange Rewards pill, flush with the right edge, with the
// member's available rewards count.
class RewardsHeader extends StatelessWidget {
  const RewardsHeader({super.key, required this.animation});

  final Animation<double> animation;

  // The title gets this share of the row beside the pill, in two lines at
  // most; a longer title (Burmese on a small phone) goes under the pill.
  static const _titleShare = 0.6;
  static const _titleLinesBeside = 2;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      context.l10n.rewardsTitle,
      style: context.textTheme.headlineMedium,
    );
    final pill = BlocSelector<RewardsCubit, RewardsState, int?>(
      selector: (state) => switch (state.progress) {
        SectionReady(:final data?) => data.member.availableRewards,
        _ => null,
      },
      builder: (context, count) =>
          _RewardsPill(count: count, animation: animation),
    );
    return Padding(
      padding: EdgeInsetsDirectional.only(start: $styles.grid.pageMargin),
      child: LayoutBuilder(
        builder: (context, constraints) =>
            _fitsBeside(context, title, constraints.maxWidth)
            ? Row(
                children: [
                  Expanded(child: title),
                  $styles.insets.sm.toWidthSizedBox,
                  pill,
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(alignment: AlignmentDirectional.centerEnd, child: pill),
                  $styles.insets.sm.toHeightSizedBox,
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: $styles.grid.pageMargin,
                    ),
                    child: title,
                  ),
                ],
              ),
      ),
    );
  }

  bool _fitsBeside(BuildContext context, Text title, double width) {
    final painter = TextPainter(
      text: TextSpan(text: title.data, style: title.style),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: _titleLinesBeside,
    )..layout(maxWidth: width * _titleShare);
    final fits = !painter.didExceedMaxLines;
    painter.dispose();
    return fits;
  }
}

class _RewardsPill extends StatelessWidget {
  const _RewardsPill({required this.count, required this.animation});

  final int? count;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.appColors;
    final insets = $styles.insets;
    final count = this.count;
    final radius = Radius.circular($styles.corner.lg);
    return PressableScale(
      semanticLabel: count == null ? null : l10n.rewardsAvailable(count),
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.highlight,
          borderRadius: BorderRadiusDirectional.horizontal(
            start: radius,
          ).resolve(Directionality.of(context)),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            insets.md,
            insets.xs,
            insets.md,
            insets.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.rewardsBadgeLabel,
                style: context.textTheme.titleLarge?.copyWith(
                  color: colors.onPrimary,
                ),
              ),
              if (count != null) ...[
                insets.xs.toWidthSizedBox,
                // Pops in with an overshoot during the entrance.
                ScaleTransition(
                  scale: animation.drive(
                    CurveTween(curve: AppMotion.rewardsBadge),
                  ),
                  child: _CountBadge(count: count),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      constraints: BoxConstraints(
        minWidth: $styles.size.icon,
        minHeight: $styles.size.icon,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxs),
      decoration: ShapeDecoration(
        color: colors.onPrimary,
        shape: const StadiumBorder(),
      ),
      child: Text(
        '$count',
        style: context.textTheme.titleSmall?.copyWith(color: colors.highlight),
      ),
    );
  }
}
