import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../../member/domain/entity/member_entity.dart';
import 'member_tier_label.dart';

// Photo, name, tier and the points-to-next-tier pill.
class MemberSummary extends StatelessWidget {
  const MemberSummary({super.key, required this.member});

  // Keeps the name clear of the bell on the right edge.
  static const _bellReserve = 64.0;

  final MemberEntity member;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: _bellReserve),
          child: Row(
            children: [
              _Avatar(member: member),
              $styles.insets.md.toWidthSizedBox,
              Expanded(
                child: _NameAndTier(member: member, l10n: l10n),
              ),
            ],
          ),
        ),
        $styles.insets.md.toHeightSizedBox,
        _PointsPill(text: _pointsText(context, l10n)),
      ],
    );
  }

  String _pointsText(BuildContext context, AppLocalizations l10n) {
    final nextTier = member.nextTier;
    final points = member.pointsToNextTier;
    if (nextTier == null || points == null) return l10n.homeTopTier;
    return l10n.homePointsToNextTier(
      points.grouped(context),
      nextTier.label(l10n),
    );
  }
}

class _NameAndTier extends StatelessWidget {
  const _NameAndTier({required this.member, required this.l10n});

  final MemberEntity member;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.headlineMedium,
        ),
        Text(
          l10n.homeMemberTier(member.tier.label(l10n)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.member});

  static const _size = 64.0;
  static const _ringGap = 4.0;

  final MemberEntity member;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final photo = member.photo;
    return CustomPaint(
      foregroundPainter: _ArcPainter(color: colors.highlight),
      child: Padding(
        padding: const EdgeInsets.all(_ringGap),
        child: SizedBox.square(
          dimension: _size,
          child: ClipOval(
            child: photo == null
                ? ColoredBox(
                    color: colors.surfaceMuted,
                    child: Icon(
                      CupertinoIcons.person_fill,
                      color: colors.textSecondary,
                    ),
                  )
                : AppImage(photo, semanticLabel: member.name),
          ),
        ),
      ),
    );
  }
}

// The orange arc hugging the right side of the photo in the design.
class _ArcPainter extends CustomPainter {
  const _ArcPainter({required this.color});

  static const _strokeWidth = 3.0;
  static const _startAngle = -math.pi / 3;
  static const _sweepAngle = math.pi * 2 / 3;

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    final rect = Offset.zero & size;
    canvas.drawArc(
      rect.deflate(_strokeWidth / 2),
      _startAngle,
      _sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) => oldDelegate.color != color;
}

class _PointsPill extends StatelessWidget {
  const _PointsPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.appColors.surface,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: insets.md,
          vertical: insets.xs,
        ),
        child: Text(text, maxLines: 2, style: context.textTheme.bodySmall),
      ),
    );
  }
}
