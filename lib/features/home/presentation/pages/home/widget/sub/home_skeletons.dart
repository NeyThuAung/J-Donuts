import 'package:flutter/material.dart';

import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import 'banner_carousel.dart';

// Shimmering placeholders shaped like each Home section (no spinners).

class MemberSkeleton extends StatelessWidget {
  const MemberSkeleton({super.key});

  static const _avatar = 72.0;
  static const _nameWidth = 120.0;
  static const _nameHeight = 28.0;
  static const _tierWidth = 96.0;
  static const _lineHeight = 14.0;
  static const _pillWidth = 240.0;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    return AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SkeletonBox.circle(size: _avatar),
              insets.md.toWidthSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonBox(width: _nameWidth, height: _nameHeight),
                  insets.xs.toHeightSizedBox,
                  const SkeletonBox(width: _tierWidth, height: _lineHeight),
                ],
              ),
            ],
          ),
          insets.md.toHeightSizedBox,
          SkeletonBox(
            width: _pillWidth,
            height: _nameHeight,
            radius: $styles.corner.lg,
          ),
        ],
      ),
    );
  }
}

class BannerSkeleton extends StatelessWidget {
  const BannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.only(start: $styles.grid.pageMargin),
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: FractionallySizedBox(
        widthFactor: BannerCarousel.viewportFraction,
        heightFactor: 1,
        child: AppShimmer(
          child: SkeletonBox(
            height: double.infinity,
            radius: $styles.corner.lg,
          ),
        ),
      ),
    ),
  );
}

/// A title bar and two tiles, for the product sections and the shops.
class RowSectionSkeleton extends StatelessWidget {
  const RowSectionSkeleton({
    super.key,
    required this.tileWidth,
    required this.tileHeight,
  });

  static const _titleWidth = 160.0;
  static const _titleHeight = 22.0;
  static const _tiles = 2;

  final double tileWidth;
  final double tileHeight;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    return AppShimmer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox(width: _titleWidth, height: _titleHeight),
            insets.md.toHeightSizedBox,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  for (var i = 0; i < _tiles; i++) ...[
                    SkeletonBox(
                      width: tileWidth,
                      height: tileHeight,
                      radius: $styles.corner.md,
                    ),
                    insets.sm.toWidthSizedBox,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
