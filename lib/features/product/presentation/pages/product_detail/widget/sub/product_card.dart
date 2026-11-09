import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/cart_rules.dart';
import '../../cubit/product_detail_cubit.dart';
import 'quantity_stepper.dart';

// White card with code, name, price, New badge and image; the quantity
// stepper sits on its bottom edge, half in and half out, as in the design.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.state,
    required this.onIncrement,
    required this.onDecrement,
  });

  static const _imageHeight = 220.0;

  final ProductDetailReady state;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    const halfStepper = QuantityStepper.height / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: halfStepper),
          child: _CardBody(state: state, bottomSpace: halfStepper),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
            child: QuantityStepper(
              quantity: state.quantity,
              onIncrement: state.quantity < CartRules.maxQuantity
                  ? onIncrement
                  : null,
              onDecrement: state.quantity > CartRules.minQuantity
                  ? onDecrement
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({required this.state, required this.bottomSpace});

  final ProductDetailReady state;
  final double bottomSpace;

  @override
  Widget build(BuildContext context) {
    final product = state.product;
    final insets = $styles.insets;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        insets.lg,
        insets.lg,
        insets.lg,
        insets.lg + bottomSpace,
      ),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular($styles.corner.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Heading(state: state),
          insets.lg.toHeightSizedBox,
          SizedBox(
            height: ProductCard._imageHeight,
            width: double.infinity,
            child: AppImage(
              product.image,
              fit: BoxFit.contain,
              semanticLabel: product.name,
            ),
          ),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({required this.state});

  final ProductDetailReady state;

  @override
  Widget build(BuildContext context) {
    final product = state.product;
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.code,
                style: textTheme.bodyMedium?.copyWith(
                  color: context.appColors.textSecondary,
                ),
              ),
            ),
            if (product.isNew) PillBadge(label: l10n.productNew),
          ],
        ),
        $styles.insets.xxs.toHeightSizedBox,
        Text(product.name, style: textTheme.headlineMedium),
        $styles.insets.xxs.toHeightSizedBox,
        Text(
          l10n.productPrice(product.priceMmk.grouped(context)),
          style: textTheme.titleSmall,
        ),
      ],
    );
  }
}
