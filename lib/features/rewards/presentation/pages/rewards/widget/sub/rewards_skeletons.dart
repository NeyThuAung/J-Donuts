import 'package:flutter/material.dart';

import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import 'challenge_art.dart';
import 'points_ring.dart';

// Shimmering placeholders shaped like the Rewards sections (no spinners).

class RewardsSummarySkeleton extends StatelessWidget {
  const RewardsSummarySkeleton({super.key});

  static const _tiers = 3;
  static const _badge = 40.0;
  static const _nameWidth = 72.0;
  static const _nameHeight = 18.0;
  static const _lineWidth = 120.0;
  static const _lineHeight = 14.0;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    return AppShimmer(
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: $styles.grid.pageMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < _tiers; i++) ...[
                    if (i > 0) insets.lg.toHeightSizedBox,
                    Row(
                      children: [
                        const SkeletonBox.circle(size: _badge),
                        insets.sm.toWidthSizedBox,
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonBox(
                              width: _nameWidth,
                              height: _nameHeight,
                            ),
                            SizedBox(height: _lineHeight / 2),
                            SkeletonBox(
                              width: _lineWidth,
                              height: _lineHeight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            insets.sm.toWidthSizedBox,
            const SkeletonBox.circle(size: PointsRing.maxSize),
          ],
        ),
      ),
    );
  }
}

class ChallengeListSkeleton extends StatelessWidget {
  const ChallengeListSkeleton({super.key});

  static const _cards = 2;
  static const _titleWidth = 140.0;
  static const _titleHeight = 22.0;
  static const _lineWidth = 48.0;
  static const _lineHeight = 16.0;
  static const _buttonWidth = 96.0;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    return AppShimmer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
        child: Column(
          children: [
            for (var i = 0; i < _cards; i++) ...[
              if (i > 0) $styles.grid.cardGap.toHeightSizedBox,
              Row(
                children: [
                  SkeletonBox(
                    width: ChallengeArt.maxSize,
                    height: ChallengeArt.maxSize,
                    radius: $styles.corner.lg,
                  ),
                  insets.lg.toWidthSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SkeletonBox(
                        width: _titleWidth,
                        height: _titleHeight,
                      ),
                      insets.xs.toHeightSizedBox,
                      const SkeletonBox(width: _lineWidth, height: _lineHeight),
                      insets.md.toHeightSizedBox,
                      SkeletonBox(
                        width: _buttonWidth,
                        height: $styles.size.minTapTarget,
                        radius: $styles.corner.lg,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
