import 'dart:math' as math;

import 'package:flutter/widgets.dart';

// The pink donut ring from screen 10: a grey track, a glazed pink arc from
// 12 o'clock clockwise for [sweep] (0 to 1) with round ends, and sprinkles
// that appear as the arc reaches them.
class PointsRingPainter extends CustomPainter {
  const PointsRingPainter({
    required this.sweep,
    required this.trackColor,
    required this.glazeColor,
    required this.shadeColor,
    required this.shineColor,
    required this.sprinkleColor,
  });

  /// Stroke width as a share of the ring's diameter.
  static const strokeShare = 0.22;

  static const _start = -math.pi / 2;
  static const _sprinkleCount = 22;
  static const _sprinkleLength = 0.3;
  static const _sprinkleWidth = 0.07;
  static const _sprinkleSpread = 0.28;
  static const _seed = 7;

  // Fixed positions so the sprinkles never move between frames: angle
  // (0 to 1 of a turn), offset across the band (-1 to 1) and tilt.
  static final _sprinkles = _scatter();

  final double sweep;
  final Color trackColor;
  final Color glazeColor;
  final Color shadeColor;
  final Color shineColor;
  final Color sprinkleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * strokeShare;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;
    final band = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(center, radius, _bandPaint(stroke)..color = trackColor);
    if (sweep <= 0) return;
    final glaze = _bandPaint(stroke)
      ..shader = _glazeShader(center, radius, stroke);
    canvas.drawArc(band, _start, sweep * 2 * math.pi, false, glaze);
    _paintSprinkles(canvas, center, radius, stroke);
  }

  Paint _bandPaint(double stroke) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = stroke
    ..strokeCap = StrokeCap.round;

  // Lighter on the inner edge, darker on the outer one, like a glazed tube.
  Shader _glazeShader(Offset center, double radius, double stroke) {
    final outer = radius + stroke / 2;
    final inner = (radius - stroke / 2) / outer;
    return RadialGradient(
      colors: [shineColor, glazeColor, shadeColor],
      stops: [inner, (inner + 1) / 2, 1],
    ).createShader(Rect.fromCircle(center: center, radius: outer));
  }

  void _paintSprinkles(
    Canvas canvas,
    Offset center,
    double radius,
    double stroke,
  ) {
    final paint = Paint()
      ..color = sprinkleColor
      ..strokeWidth = stroke * _sprinkleWidth
      ..strokeCap = StrokeCap.round;
    final half = stroke * _sprinkleLength / 2;
    for (final (turn, across, tilt) in _sprinkles) {
      if (turn > sweep) continue;
      final angle = _start + turn * 2 * math.pi;
      final distance = radius + across * stroke * _sprinkleSpread;
      final at = center + Offset.fromDirection(angle, distance);
      final direction = Offset.fromDirection(angle + tilt, half);
      canvas.drawLine(at - direction, at + direction, paint);
    }
  }

  static List<(double, double, double)> _scatter() {
    final random = math.Random(_seed);
    return [
      for (var i = 0; i < _sprinkleCount; i++)
        (
          (i + random.nextDouble()) / _sprinkleCount,
          random.nextDouble() * 2 - 1,
          random.nextDouble() * math.pi,
        ),
    ];
  }

  @override
  bool shouldRepaint(PointsRingPainter oldDelegate) =>
      oldDelegate.sweep != sweep ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.glazeColor != glazeColor ||
      oldDelegate.shadeColor != shadeColor ||
      oldDelegate.shineColor != shineColor ||
      oldDelegate.sprinkleColor != sprinkleColor;
}
