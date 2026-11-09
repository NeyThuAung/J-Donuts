import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/tier_progress_entity.dart';
import 'points_ring_painter.dart';

// The donut ring sweeps from 0 to the member's progress while the total
// counts up to their points. It bleeds past the screen edge, as in the
// design.
class PointsRing extends StatelessWidget {
  const PointsRing({
    super.key,
    required this.progress,
    required this.size,
    required this.animation,
  });

  static const maxSize = 176.0;
  static const _minSize = 132.0;
  static const _widthShare = 0.48;
  static const _bleed = 0.12;

  // How far the glaze moves toward white (shine) or ink (shade).
  static const _shine = 0.35;
  static const _shade = 0.12;
  static const _sprinkleOpacity = 0.7;

  // Text stays a little clear of the band.
  static const _holeInset = 1.25;

  /// About half the row, so the tier ladder keeps room on a small phone.
  static double sizeFor(double rowWidth) =>
      (rowWidth * _widthShare).clamp(_minSize, maxSize);

  final TierProgressEntity progress;
  final double size;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final points = progress.member.points;
    final ring = animation.drive(CurveTween(curve: AppMotion.rewardsRing));
    return Semantics(
      label: '${l10n.rewardsTotalPoints} ${points.grouped(context)}',
      excludeSemantics: true,
      child: Transform.translate(
        offset: Offset(_bleedOffset(context), 0),
        child: SizedBox.square(
          dimension: size,
          child: AnimatedBuilder(
            animation: ring,
            builder: (context, _) => CustomPaint(
              painter: _painter(context, ring.value),
              child: _Total(
                points: (points * ring.value).round(),
                inset: size * PointsRingPainter.strokeShare * _holeInset,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _bleedOffset(BuildContext context) {
    final offset = size * _bleed;
    return Directionality.of(context) == TextDirection.rtl ? -offset : offset;
  }

  PointsRingPainter _painter(BuildContext context, double t) {
    final colors = context.appColors;
    final glaze = colors.accent;
    return PointsRingPainter(
      sweep: progress.overallProgress * t,
      trackColor: colors.track,
      glazeColor: glaze,
      shineColor: Color.lerp(glaze, colors.surface, _shine)!,
      shadeColor: Color.lerp(glaze, colors.textPrimary, _shade)!,
      sprinkleColor: colors.surface.withValues(alpha: _sprinkleOpacity),
    );
  }
}

class _Total extends StatelessWidget {
  const _Total({required this.points, required this.inset});

  final int points;

  /// Keeps the text inside the ring's hole.
  final double inset;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = context.textTheme;
    return Padding(
      padding: EdgeInsets.all(inset),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Text(
                context.l10n.rewardsTotalPoints,
                maxLines: 1,
                style: textTheme.titleSmall?.copyWith(color: colors.accent),
              ),
              Text(
                points.grouped(context),
                maxLines: 1,
                style: textTheme.headlineSmall?.copyWith(
                  color: colors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
