import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../../member/domain/entity/member_tier.dart';
import '../../../../../../member/presentation/member_tier_label.dart';

// A tier's shield from screen 10: metallic body, lighter inner plate, one
// star per tier rank and the tier's initial.
class TierShield extends StatelessWidget {
  const TierShield({super.key, required this.tier, required this.size});

  // Body height over width.
  static const aspect = 1.12;

  // How far the metal moves toward white (shine) or ink (shade, marks).
  static const _shine = 0.45;
  static const _shade = 0.18;
  static const _mark = 0.45;

  final MemberTier tier;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final base = switch (tier) {
      MemberTier.silver => colors.tierSilver,
      MemberTier.gold => colors.tierGold,
      MemberTier.platinum => colors.tierPlatinum,
    };
    final mark = Color.lerp(base, colors.textPrimary, _mark)!;
    final initial = tier.label(context.l10n).characters.first;
    return SizedBox(
      width: size,
      height: size * aspect,
      child: CustomPaint(
        painter: _ShieldPainter(
          base: base,
          shine: Color.lerp(base, colors.surface, _shine)!,
          shade: Color.lerp(base, colors.textPrimary, _shade)!,
          mark: mark,
          stars: tier.index + 1,
        ),
        child: Align(
          alignment: _ShieldPainter.initialAlignment,
          child: Text(
            initial,
            textScaler: TextScaler.noScaling,
            style: context.textTheme.titleMedium?.copyWith(
              color: mark,
              fontSize: size * _ShieldPainter.initialShare,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _ShieldPainter extends CustomPainter {
  const _ShieldPainter({
    required this.base,
    required this.shine,
    required this.shade,
    required this.mark,
    required this.stars,
  });

  static const initialAlignment = Alignment(0, 0.25);
  static const initialShare = 0.36;

  // Shield outline as fractions of width / height, clockwise from the top.
  static const _outline = [
    Offset(0.5, 0.02),
    Offset(0.96, 0.2),
    Offset(0.96, 0.6),
    Offset(0.5, 0.98),
    Offset(0.04, 0.6),
    Offset(0.04, 0.2),
  ];
  static const _plateScale = 0.74;
  static const _cornerShare = 0.12;
  static const _starRadiusShare = 0.09;
  static const _starsY = 0.3;
  static const _starGapShare = 0.2;
  static const _starPoints = 5;
  static const _starInner = 0.45;

  final Color base;
  final Color shine;
  final Color shade;
  final Color mark;
  final int stars;

  @override
  void paint(Canvas canvas, Size size) {
    final body = _shield(size, 1);
    final corner = size.width * _cornerShare;
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [shine, base, shade],
      ).createShader(Offset.zero & size);
    _drawRounded(canvas, body, bodyPaint, corner);
    _drawRounded(
      canvas,
      _shield(size, _plateScale),
      Paint()..color = shine,
      corner,
    );
    _paintStars(canvas, size);
  }

  // Fill plus a round-joined stroke of the same paint softens the corners.
  void _drawRounded(Canvas canvas, Path path, Paint paint, double corner) {
    canvas
      ..drawPath(path, paint..style = PaintingStyle.fill)
      ..drawPath(
        path,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = corner
          ..strokeJoin = StrokeJoin.round,
      );
  }

  Path _shield(Size size, double scale) {
    final center = size.center(Offset.zero);
    final points = [
      for (final point in _outline)
        center +
            (Offset(point.dx * size.width, point.dy * size.height) - center) *
                scale *
                (1 - _cornerShare),
    ];
    return Path()..addPolygon(points, true);
  }

  void _paintStars(Canvas canvas, Size size) {
    final radius = size.width * _starRadiusShare;
    final gap = size.width * _starGapShare;
    final firstX = size.width / 2 - (stars - 1) * gap / 2;
    final paint = Paint()..color = mark;
    for (var i = 0; i < stars; i++) {
      final center = Offset(firstX + i * gap, size.height * _starsY);
      canvas.drawPath(_star(center, radius), paint);
    }
  }

  Path _star(Offset center, double radius) {
    const corners = _starPoints * 2;
    final path = Path();
    for (var i = 0; i < corners; i++) {
      final r = i.isEven ? radius : radius * _starInner;
      final angle = -math.pi / 2 + i * math.pi / _starPoints;
      final point = center + Offset.fromDirection(angle, r);
      i == 0
          ? path.moveTo(point.dx, point.dy)
          : path.lineTo(point.dx, point.dy);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(_ShieldPainter oldDelegate) =>
      oldDelegate.base != base ||
      oldDelegate.shine != shine ||
      oldDelegate.shade != shade ||
      oldDelegate.mark != mark ||
      oldDelegate.stars != stars;
}
