import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/challenge_tab.dart';
import '../../cubit/rewards_cubit.dart';

// "Eat more earn more" and "Gift" on the edge between the white panel and
// the grey list. The cyan pill slides to the selected tab and the labels
// fade between colours; both shrink together on a narrow screen.
class ChallengeTabs extends StatelessWidget {
  const ChallengeTabs({super.key});

  // Hard stop: the top half is the panel's colour, the bottom half the list's.
  static const _split = [0.5, 0.5];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.surface, colors.background],
          stops: _split,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: BlocSelector<RewardsCubit, RewardsState, ChallengeTab>(
              selector: (state) => state.tab,
              builder: (context, selected) => _SlidingTabs(selected: selected),
            ),
          ),
        ),
      ),
    );
  }
}

class _SlidingTabs extends StatelessWidget {
  const _SlidingTabs({required this.selected});

  static const _outlineWidth = 3.0;

  final ChallengeTab selected;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    final style = context.textTheme.titleLarge;
    final sizes = [
      for (final tab in ChallengeTab.values) _pillSize(context, tab, style),
    ];
    final starts = [
      for (
        var i = 0, x = 0.0;
        i < sizes.length;
        x += sizes[i].width + insets.xs, i++
      )
        x,
    ];
    final totalWidth = starts.last + sizes.last.width;
    final index = selected.index;
    return SizedBox(
      width: totalWidth,
      height: sizes.first.height,
      child: Stack(
        children: [
          for (final tab in ChallengeTab.values)
            PositionedDirectional(
              start: starts[tab.index],
              width: sizes[tab.index].width,
              top: 0,
              bottom: 0,
              child: _pill(context, context.appColors.track),
            ),
          AnimatedPositionedDirectional(
            duration: context.motion(AppMotion.tabSwitch),
            curve: AppMotion.emphasized,
            start: starts[index],
            width: sizes[index].width,
            top: 0,
            bottom: 0,
            child: _pill(context, context.appColors.primary),
          ),
          for (final tab in ChallengeTab.values)
            PositionedDirectional(
              start: starts[tab.index],
              width: sizes[tab.index].width,
              top: 0,
              bottom: 0,
              child: _TabLabel(tab: tab, isSelected: tab == selected),
            ),
        ],
      ),
    );
  }

  Widget _pill(BuildContext context, Color color) => DecoratedBox(
    decoration: ShapeDecoration(
      color: color,
      shape: StadiumBorder(
        side: BorderSide(
          color: context.appColors.surface,
          width: _outlineWidth,
        ),
      ),
    ),
  );

  // The label laid out for real at the current text scale, plus padding.
  Size _pillSize(BuildContext context, ChallengeTab tab, TextStyle? style) {
    final insets = $styles.insets;
    final painter = TextPainter(
      text: TextSpan(text: tab.label(context.l10n), style: style),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final size = Size(
      painter.width + 2 * (insets.lg + _outlineWidth),
      painter.height + 2 * (insets.xs + _outlineWidth),
    );
    painter.dispose();
    return size;
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({required this.tab, required this.isSelected});

  final ChallengeTab tab;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      selected: isSelected,
      button: true,
      child: PressableScale(
        onTap: () => context.read<RewardsCubit>().selectTab(tab),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: context.motion(AppMotion.tabSwitch),
            curve: AppMotion.standard,
            style: (context.textTheme.titleLarge ?? const TextStyle()).copyWith(
              color: isSelected ? colors.onPrimary : colors.textSecondary,
            ),
            child: Text(tab.label(context.l10n), maxLines: 1),
          ),
        ),
      ),
    );
  }
}

extension ChallengeTabLabel on ChallengeTab {
  String label(AppLocalizations l10n) => switch (this) {
    ChallengeTab.earn => l10n.rewardsTabEarn,
    ChallengeTab.gift => l10n.rewardsTabGift,
  };
}
