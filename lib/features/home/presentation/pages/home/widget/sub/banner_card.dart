import 'package:flutter/material.dart';

import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/banner_entity.dart';

// Coloured card with the tag, the title and the photo framed at the bottom;
// the header's rounded edge clips its bottom, as in the design.
class BannerCard extends StatelessWidget {
  const BannerCard({super.key, required this.banner, required this.index});

  static const _photoWidthFactor = 0.66;
  static const _titleMaxLines = 2;
  static const _frameWidth = 2.0;

  final BannerEntity banner;

  /// Picks the card colour, so neighbours differ.
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final cardColors = [colors.banner, colors.primary, colors.accent];
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular($styles.corner.lg),
      ),
      child: ColoredBox(
        color: cardColors[index % cardColors.length],
        child: Column(
          children: [
            $styles.insets.sm.toHeightSizedBox,
            PillBadge(label: banner.tag),
            $styles.insets.xs.toHeightSizedBox,
            _Title(text: banner.title, maxLines: _titleMaxLines),
            $styles.insets.xs.toHeightSizedBox,
            Expanded(child: _FramedPhoto(banner: banner)),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.text, required this.maxLines});

  final String text;
  final int maxLines;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
    child: Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: context.textTheme.titleLarge?.copyWith(
        color: context.appColors.onPrimary,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _FramedPhoto extends StatelessWidget {
  const _FramedPhoto({required this.banner});

  final BannerEntity banner;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular($styles.corner.md);
    return FractionallySizedBox(
      widthFactor: BannerCard._photoWidthFactor,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.appColors.surface,
            width: BannerCard._frameWidth,
          ),
          borderRadius: BorderRadius.vertical(top: radius),
        ),
        child: AppImage(
          banner.image,
          borderRadius: BorderRadius.vertical(top: radius),
          semanticLabel: banner.title,
        ),
      ),
    );
  }
}
