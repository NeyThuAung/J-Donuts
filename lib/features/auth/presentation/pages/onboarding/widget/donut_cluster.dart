import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/resources/r.dart';
import '../../../../../../shared/styles/styles.dart';

// Share of the cluster height that fades into the page colour at the bottom.
const _fadeShare = 0.3;
// Donut image size as a share of its circle.
const _imageShare = 0.82;

// One coloured circle with a donut; positions and sizes are shares of the
// cluster so it scales from small to large phones.
class _Bubble {
  const _Bubble({
    required this.center,
    required this.radius,
    required this.color,
    required this.image,
    required this.driftFrom,
  });

  /// x as a share of the width, y as a share of the height.
  final Offset center;

  /// Share of the shorter side of the cluster.
  final double radius;
  final Color color;
  final AssetGenImage image;

  /// Where it drifts in from, as a share of its own size.
  final Offset driftFrom;
}

List<_Bubble> _bubbles(AppThemeColors colors) => [
  _Bubble(
    center: const Offset(0.5, 0.42),
    radius: 0.28,
    color: colors.homeHeader,
    image: R.images.donutPinkSprinkles,
    driftFrom: const Offset(0, 0.25),
  ),
  _Bubble(
    center: const Offset(0.02, 0.08),
    radius: 0.26,
    color: colors.primary,
    image: R.images.donutGreenSprinkles,
    driftFrom: const Offset(-0.4, -0.3),
  ),
  _Bubble(
    center: const Offset(1, 0.1),
    radius: 0.18,
    color: colors.progressSecondary,
    image: R.images.donutChocolateHearts,
    driftFrom: const Offset(0.4, -0.3),
  ),
  _Bubble(
    center: const Offset(0, 0.74),
    radius: 0.19,
    color: colors.banner,
    image: R.images.donutChocolateStrawberry,
    driftFrom: const Offset(-0.5, 0),
  ),
  _Bubble(
    center: const Offset(1, 0.72),
    radius: 0.2,
    color: colors.progressSecondary,
    image: R.images.donutChocolateSprinkles,
    driftFrom: const Offset(0.5, 0),
  ),
  _Bubble(
    center: const Offset(0.5, 1.06),
    radius: 0.24,
    color: colors.highlight,
    image: R.images.donutGreenSprinkles,
    driftFrom: const Offset(0, 0.4),
  ),
];

// The decorative donut circles at the top of Onboarding. They drift in from
// the screen edges one after another (entrance slots 0–5).
class DonutCluster extends StatelessWidget {
  const DonutCluster({
    super.key,
    required this.animation,
    required this.height,
  });

  static const entranceSlots = 6;

  final Animation<double> animation;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bubbles = _bubbles(colors);
    return ExcludeSemantics(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            for (final (index, bubble) in bubbles.indexed)
              _positioned(context, bubble, index),
            Positioned.fill(
              top: height * (1 - _fadeShare),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.authGradientTop.withValues(alpha: 0),
                      colors.authGradientTop,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _positioned(BuildContext context, _Bubble bubble, int index) {
    final width = MediaQuery.sizeOf(context).width;
    final diameter = 2 * bubble.radius * math.min(width, height);
    return Positioned(
      left: bubble.center.dx * width - diameter / 2,
      top: bubble.center.dy * height - diameter / 2,
      width: diameter,
      height: diameter,
      child: EntranceItem(
        animation: animation,
        index: index,
        slideFrom: bubble.driftFrom,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bubble.color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: bubble.image.image(
              width: diameter * _imageShare,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
