import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../../product/domain/entity/product_entity.dart';
import '../../../../../domain/entity/home_section_type.dart';

/// Tile sizes per section type, from the design.
extension HomeSectionTileSize on HomeSectionType {
  static const _nameLines = 2;

  double get tileWidth => switch (this) {
    HomeSectionType.seasonal => 232,
    HomeSectionType.popular || HomeSectionType.orderAgain => 156,
  };

  double get imageHeight => switch (this) {
    HomeSectionType.seasonal => 152,
    HomeSectionType.popular => 232,
    HomeSectionType.orderAgain => 112,
  };

  /// Scopes the product Hero tag and the detail route's `from`.
  String get heroFrom => name;

  /// Image, gap and two name lines at the current text scale.
  double tileHeight(BuildContext context) =>
      imageHeight +
      $styles.insets.sm +
      context.textLinesHeight(context.textTheme.titleSmall, _nameLines);
}

// Seasonal tiles are full photos; Popular and Order again sit on a white card.
class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.type,
    required this.onTap,
  });

  final ProductEntity product;
  final HomeSectionType type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      semanticLabel: product.name,
      child: SizedBox(
        width: type.tileWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: type.imageHeight, child: _Picture(product, type)),
            $styles.insets.sm.toHeightSizedBox,
            Text(
              product.name,
              maxLines: HomeSectionTileSize._nameLines,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _Picture extends StatelessWidget {
  const _Picture(this.product, this.type);

  final ProductEntity product;
  final HomeSectionType type;

  String get _heroTag => HeroTags.product(from: type.heroFrom, id: product.id);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular($styles.corner.md);
    final discount = product.discountPercent;
    final isPhoto = type == HomeSectionType.seasonal;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (isPhoto)
          AppHeroImage(
            tag: _heroTag,
            image: product.image,
            borderRadius: radius,
          )
        else
          _CardImage(product: product, radius: radius, heroTag: _heroTag),
        if (discount != null)
          PositionedDirectional(
            end: $styles.insets.xs,
            bottom: $styles.insets.xs,
            child: PillBadge(label: context.l10n.homeDiscountOff(discount)),
          ),
      ],
    );
  }
}

// Only the product flies to the detail page; the white card stays.
class _CardImage extends StatelessWidget {
  const _CardImage({
    required this.product,
    required this.radius,
    required this.heroTag,
  });

  final ProductEntity product;
  final BorderRadius radius;
  final String heroTag;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: context.appColors.surface,
      borderRadius: radius,
    ),
    child: Padding(
      padding: EdgeInsets.all($styles.insets.sm),
      child: AppHeroImage(
        tag: heroTag,
        image: product.image,
        fit: BoxFit.contain,
      ),
    ),
  );
}
