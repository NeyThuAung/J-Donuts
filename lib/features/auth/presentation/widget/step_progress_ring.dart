import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/styles/styles.dart';
import 'auth_step.dart';

// Values above 1 drive the last step's morph from full ring to check.
const _checkMorphEnd = 2.0;

// Sweeps from the previous step's share to this step's (25 → 50 → 75 → 100%),
// then the last step fills in and draws a check.
class StepProgressRing extends StatelessWidget {
  const StepProgressRing({super.key, required this.step});

  final AuthStep step;

  @override
  Widget build(BuildContext context) {
    final isLast = step == AuthStep.values.last;
    final colors = context.appColors;
    return Semantics(
      label: context.l10n.authStepProgress(step.number, step.total),
      child: TweenAnimationBuilder<double>(
        tween: Tween(
          begin: step.previousProgress,
          end: isLast ? _checkMorphEnd : step.progress,
        ),
        duration: context.motion(
          isLast
              ? AppMotion.progressRing + AppMotion.ringToCheck
              : AppMotion.progressRing,
        ),
        curve: AppMotion.sweep,
        builder: (context, value, _) => CustomPaint(
          size: Size.square($styles.size.stepRing),
          painter: StepRingPainter(
            value: value,
            stroke: $styles.size.stepRingStroke,
            trackColor: colors.progressSecondary,
            progressColor: colors.accent,
            checkColor: colors.onPrimary,
          ),
        ),
      ),
    );
  }
}

class StepRingPainter extends CustomPainter {
  const StepRingPainter({
    required this.value,
    required this.stroke,
    required this.trackColor,
    required this.progressColor,
    required this.checkColor,
  });

  final double value;
  final double stroke;
  final Color trackColor;
  final Color progressColor;
  final Color checkColor;

  static const _startAngle = -math.pi / 2;
  // Check mark points as fractions of the ring size.
  static const _checkPoints = [
    Offset(0.3, 0.52),
    Offset(0.44, 0.66),
    Offset(0.71, 0.38),
  ];
  // Share of the morph spent filling the circle before the check draws.
  static const _fillShare = 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas
      ..drawCircle(center, radius, ring..color = trackColor)
      ..drawArc(
        Rect.fromCircle(center: center, radius: radius),
        _startAngle,
        2 * math.pi * value.clamp(0.0, 1.0),
        false,
        ring..color = progressColor,
      );
    final morph = (value - 1).clamp(0.0, 1.0);
    if (morph > 0) _paintCheck(canvas, size, morph);
  }

  void _paintCheck(Canvas canvas, Size size, double morph) {
    final fill = (morph / _fillShare).clamp(0.0, 1.0);
    canvas.drawCircle(
      size.center(Offset.zero),
      size.shortestSide / 2 * fill,
      Paint()..color = progressColor,
    );
    final draw = ((morph - _fillShare) / (1 - _fillShare)).clamp(0.0, 1.0);
    if (draw == 0) return;
    final points = [
      for (final point in _checkPoints)
        Offset(point.dx * size.width, point.dy * size.height),
    ];
    final check = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy);
    final metric = check.computeMetrics().first;
    canvas.drawPath(
      metric.extractPath(0, metric.length * draw),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke / 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = checkColor,
    );
  }

  @override
  bool shouldRepaint(StepRingPainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.stroke != stroke ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.progressColor != progressColor ||
      oldDelegate.checkColor != checkColor;
}
