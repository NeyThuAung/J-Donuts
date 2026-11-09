import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/shop_entity.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({super.key, required this.shop});

  static const width = 276.0;
  static const _imageHeight = 140.0;
  static const _addressLines = 2;

  final ShopEntity shop;

  /// Card height at the current text scale.
  static double height(BuildContext context) {
    final textTheme = context.textTheme;
    final insets = $styles.insets;
    return _imageHeight +
        insets.md * 2 +
        insets.sm +
        insets.xs * 2 +
        context.textLinesHeight(textTheme.titleMedium, 1) +
        context.textLinesHeight(textTheme.bodyMedium, _addressLines) +
        context.textLinesHeight(textTheme.titleSmall, 1);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = context.textTheme;
    final insets = $styles.insets;
    return Container(
      width: width,
      padding: EdgeInsets.all(insets.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular($styles.corner.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _imageHeight,
            width: double.infinity,
            child: AppImage(
              shop.image,
              borderRadius: BorderRadius.circular($styles.corner.md),
              semanticLabel: shop.name,
            ),
          ),
          insets.sm.toHeightSizedBox,
          Text(
            shop.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleMedium,
          ),
          insets.xs.toHeightSizedBox,
          Text(
            shop.address,
            maxLines: _addressLines,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
          ),
          insets.xs.toHeightSizedBox,
          Text(
            context.l10n.homeOrderOnline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall?.copyWith(color: colors.accent),
          ),
        ],
      ),
    );
  }
}
