import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../../member/domain/entity/member_entity.dart';
import '../../../../../../member/presentation/member_tier_label.dart';
import '../../../../../domain/entity/tier_entity.dart';
import '../../../../../domain/entity/tier_progress_entity.dart';
import 'tier_shield.dart';

// Silver → Gold → Platinum. Tiers appear top to bottom, the member's tier
// is highlighted (full-size shield, others smaller and faded), then the
// line under it fills toward the next tier.
class TierLadder extends StatelessWidget {
  const TierLadder({
    super.key,
    required this.progress,
    required this.animation,
  });

  final TierProgressEntity progress;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final tiers = progress.tiers;
    final current = tiers.indexWhere((t) => t.tier == progress.member.tier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, tier) in tiers.indexed)
          _TierRow(
            tier: tier,
            member: progress.member,
            isCurrent: index == current,
            isFuture: index > current,
            lineFill: index == tiers.length - 1
                ? null
                : _lineFill(index, current),
            animation: animation,
            index: index,
          ),
      ],
    );
  }

  // Full below the member's tier, partial from it, empty after it.
  double _lineFill(int index, int current) {
    if (index < current) return 1;
    if (index == current) return progress.nextTierProgress;
    return 0;
  }
}

class _TierRow extends StatelessWidget {
  const _TierRow({
    required this.tier,
    required this.member,
    required this.isCurrent,
    required this.isFuture,
    required this.lineFill,
    required this.animation,
    required this.index,
  });

  static const _slot = 44.0;
  static const _otherScale = 0.82;
  static const _futureOpacity = 0.7;

  final TierEntity tier;
  final MemberEntity member;
  final bool isCurrent;
  final bool isFuture;

  /// Null for the last tier, which has no line under it.
  final double? lineFill;
  final Animation<double> animation;
  final int index;

  @override
  Widget build(BuildContext context) {
    final enter = rewardsTierInterval(index);
    final fade = animation.drive(
      CurveTween(curve: Interval(enter.begin, enter.end)),
    );
    final lineFill = this.lineFill;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _slot,
            child: Column(
              children: [
                FadeTransition(
                  opacity: fade,
                  child: ScaleTransition(
                    scale: animation.drive(CurveTween(curve: enter)),
                    child: _shield(),
                  ),
                ),
                if (lineFill != null)
                  Expanded(
                    child: _LadderLine(fill: lineFill, animation: animation),
                  ),
              ],
            ),
          ),
          $styles.insets.sm.toWidthSizedBox,
          Expanded(
            child: FadeTransition(
              opacity: fade,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: lineFill == null ? 0 : $styles.insets.lg,
                ),
                child: _TierText(tier: tier, member: member),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shield() {
    final shield = TierShield(
      tier: tier.tier,
      size: isCurrent ? _slot : _slot * _otherScale,
    );
    return SizedBox(
      height: _slot * TierShield.aspect,
      child: Center(
        child: isFuture
            ? Opacity(opacity: _futureOpacity, child: shield)
            : shield,
      ),
    );
  }
}

/// The line between two shields; its dark part grows to [fill] (0 to 1).
class _LadderLine extends StatelessWidget {
  const _LadderLine({required this.fill, required this.animation});

  static const _width = 4.0;

  final double fill;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final grow = animation.drive(
      CurveTween(curve: AppMotion.rewardsLadderLine),
    );
    return SizedBox(
      width: _width,
      child: CustomPaint(
        painter: _LinePainter(
          fill: grow.drive(Tween(begin: 0, end: fill)),
          track: colors.track,
          filled: colors.trackActive,
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter({required this.fill, required this.track, required this.filled})
    : super(repaint: fill);

  final Animation<double> fill;
  final Color track;
  final Color filled;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawRect(Offset.zero & size, Paint()..color = track)
      ..drawRect(
        Offset.zero & Size(size.width, size.height * fill.value),
        Paint()..color = filled,
      );
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.track != track ||
      oldDelegate.filled != filled;
}

class _TierText extends StatelessWidget {
  const _TierText({required this.tier, required this.member});

  final TierEntity tier;
  final MemberEntity member;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tier.tier.label(l10n),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleMedium,
          ),
          Text(
            _status(context, l10n),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  String _status(BuildContext context, AppLocalizations l10n) {
    final current = member.tier;
    final points = member.pointsToNextTier;
    if (tier.tier == current) return l10n.rewardsTierHere;
    if (tier.tier.index < current.index) return l10n.rewardsTierReached;
    if (tier.tier == member.nextTier && points != null) {
      return l10n.rewardsTierRemaining(
        points.grouped(context),
        tier.tier.label(l10n),
      );
    }
    return l10n.rewardsTierSoon;
  }
}
