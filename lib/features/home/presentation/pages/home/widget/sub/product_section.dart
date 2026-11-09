import 'package:flutter/cupertino.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../../product/domain/entity/product_entity.dart';
import '../../../../../domain/entity/home_section_entity.dart';
import '../../../../../domain/entity/home_section_type.dart';
import 'product_tiles.dart';

extension HomeSectionTitle on HomeSectionType {
  String title(AppLocalizations l10n) => switch (this) {
    HomeSectionType.seasonal => l10n.homeSeasonalSpecials,
    HomeSectionType.popular => l10n.homePopular,
    HomeSectionType.orderAgain => l10n.homeOrderAgain,
  };
}

// Title row with a "see all" chevron, then a horizontal list of tiles.
class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
    required this.section,
    required this.onProductTap,
  });

  final HomeSectionEntity section;
  final void Function(ProductEntity product) onProductTap;

  @override
  Widget build(BuildContext context) {
    final title = section.type.title(context.l10n);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleRow(title: title),
        $styles.insets.md.toHeightSizedBox,
        if (section.products.isEmpty)
          const SectionMessage.empty()
        else
          _ProductList(section: section, onProductTap: onProductTap),
      ],
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({required this.title});

  static const _maxLines = 2;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: _maxLines,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.titleLarge,
            ),
          ),
          _SeeAllButton(sectionTitle: title),
        ],
      ),
    );
  }
}

class _SeeAllButton extends StatelessWidget {
  const _SeeAllButton({required this.sectionTitle});

  static const _circle = 32.0;

  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return PressableScale(
      onTap: () => showComingSoonSheet(context, title: sectionTitle),
      semanticLabel: context.l10n.homeSeeAll(sectionTitle),
      child: SizedBox.square(
        dimension: $styles.size.minTapTarget,
        child: Center(
          child: Container(
            width: _circle,
            height: _circle,
            decoration: BoxDecoration(
              color: colors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.chevron_right,
              size: $styles.size.iconSm,
              color: colors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.section, required this.onProductTap});

  final HomeSectionEntity section;
  final void Function(ProductEntity product) onProductTap;

  @override
  Widget build(BuildContext context) {
    final products = section.products;
    return SizedBox(
      height: section.type.tileHeight(context),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: $styles.grid.pageMargin),
        itemCount: products.length,
        separatorBuilder: (_, _) => $styles.insets.md.toWidthSizedBox,
        itemBuilder: (context, index) => ProductTile(
          key: ValueKey(products[index].id),
          product: products[index],
          type: section.type,
          onTap: () => onProductTap(products[index]),
        ),
      ),
    );
  }
}
