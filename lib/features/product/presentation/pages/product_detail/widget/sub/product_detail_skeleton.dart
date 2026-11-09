import 'package:flutter/material.dart';

import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';

class ProductDetailSkeleton extends StatelessWidget {
  const ProductDetailSkeleton({super.key});

  static const _cardHeight = 400.0;
  static const _lineHeight = 14.0;
  static const _lines = 4;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    return AppShimmer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
        child: Column(
          children: [
            SkeletonBox(height: _cardHeight, radius: $styles.corner.lg),
            insets.xl.toHeightSizedBox,
            for (var i = 0; i < _lines; i++) ...[
              const SkeletonBox(height: _lineHeight),
              insets.xs.toHeightSizedBox,
            ],
          ],
        ),
      ),
    );
  }
}
