import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';

// Rounded hexagon with a star behind the header's right side.
class TierBadgeArt extends StatelessWidget {
  const TierBadgeArt({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(size),
        painter: _HexagonPainter(
          fill: colors.headerBadge,
          outline: colors.surface,
        ),
        child: SizedBox.square(
          dimension: size,
          child: Icon(
            CupertinoIcons.star_fill,
            size: size / 3,
            color: colors.headerBadgeIcon,
          ),
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  const _HexagonPainter({required this.fill, required this.outline});

  static const _corners = 6;
  static const _outlineFraction = 0.04;
  static const _cornerRounding = 0.12;
  // Leaves room for the outline inside the canvas.
  static const _shapeFraction = 0.92;

  final Color fill;
  final Color outline;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2;
    final path = _roundedHexagon(
      size.center(Offset.zero),
      radius * _shapeFraction,
    );
    canvas
      ..drawPath(path, Paint()..color = fill)
      ..drawPath(
        path,
        Paint()
          ..color = outline
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius * _outlineFraction,
      );
  }

  Path _roundedHexagon(Offset center, double radius) {
    final points = [
      for (var i = 0; i < _corners; i++)
        center +
            Offset.fromDirection(-math.pi / 2 + i * 2 * math.pi / _corners) *
                radius,
    ];
    final path = Path();
    for (var i = 0; i < _corners; i++) {
      final corner = points[i];
      final before = Offset.lerp(
        corner,
        points[(i + _corners - 1) % _corners],
        _cornerRounding,
      )!;
      final after = Offset.lerp(
        corner,
        points[(i + 1) % _corners],
        _cornerRounding,
      )!;
      i == 0
          ? path.moveTo(before.dx, before.dy)
          : path.lineTo(before.dx, before.dy);
      path.quadraticBezierTo(corner.dx, corner.dy, after.dx, after.dy);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(_HexagonPainter oldDelegate) =>
      oldDelegate.fill != fill || oldDelegate.outline != outline;
}

// Orange tab on the right edge with the bell and the unread count.
class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, required this.count, required this.onTap});

  static const _countSize = 22.0;

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final insets = $styles.insets;
    return PressableScale(
      onTap: onTap,
      semanticLabel: context.l10n.homeNotifications(count),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.highlight,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular($styles.size.minTapTarget),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            insets.md,
            insets.xs,
            insets.lg,
            insets.xs,
          ),
          child: ExcludeSemantics(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.bell, color: colors.onPrimary),
                insets.xs.toWidthSizedBox,
                _CountBubble(count: count, size: _countSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountBubble extends StatelessWidget {
  const _CountBubble({required this.count, required this.size});

  static const _maxShown = 99;

  final int count;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxs),
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: const StadiumBorder(),
      ),
      alignment: Alignment.center,
      child: Text(
        count > _maxShown ? '$_maxShown+' : '$count',
        style: context.textTheme.labelMedium?.copyWith(
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
