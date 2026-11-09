import 'package:flutter/material.dart';

import '../../../../../../../shared/styles/styles.dart';

// Clouds and rolling hills behind the nearby shops, drawn instead of an
// illustration asset.
class LandscapeBackdrop extends StatelessWidget {
  const LandscapeBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _LandscapePainter(
            sky: colors.primary,
            cloud: colors.landscapeCloud,
            hill: colors.success,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _LandscapePainter extends CustomPainter {
  const _LandscapePainter({
    required this.sky,
    required this.cloud,
    required this.hill,
  });

  // Cloud puffs as (x, y, radius) shares of the width.
  static const _puffs = [
    (0.88, 0.07, 0.15),
    (1.02, 0.03, 0.14),
    (1.06, 0.12, 0.11),
    (-0.02, 0.42, 0.08),
  ];
  static const _farHillTop = 0.62;
  static const _nearHillTop = 0.74;
  static const _farHillAlpha = 0.6;

  final Color sky;
  final Color cloud;
  final Color hill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = sky);
    final cloudPaint = Paint()..color = cloud;
    for (final (x, y, r) in _puffs) {
      canvas.drawCircle(
        Offset(size.width * x, size.height * y),
        size.width * r,
        cloudPaint,
      );
    }
    final farHill = Paint()..color = hill.withValues(alpha: _farHillAlpha);
    canvas
      ..drawPath(_hill(size, _farHillTop, rising: true), farHill)
      ..drawPath(
        _hill(size, _nearHillTop, rising: false),
        Paint()..color = hill,
      );
  }

  Path _hill(Size size, double top, {required bool rising}) {
    final y = size.height * top;
    final lift = size.height * (1 - top) / 3;
    return Path()
      ..moveTo(0, rising ? y + lift : y)
      ..quadraticBezierTo(
        size.width / 2,
        rising ? y - lift : y + lift,
        size.width,
        rising ? y : y - lift / 2,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldRepaint(_LandscapePainter oldDelegate) =>
      oldDelegate.sky != sky ||
      oldDelegate.cloud != cloud ||
      oldDelegate.hill != hill;
}
