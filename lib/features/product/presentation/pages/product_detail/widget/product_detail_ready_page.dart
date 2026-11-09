import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';
import '../cubit/product_detail_cubit.dart';
import 'sub/add_to_cart_button.dart';
import 'sub/product_card.dart';
import 'sub/product_description.dart';

// Product card with its stepper, the description, and Add to cart pinned
// at the bottom.
class ProductDetailReadyPage extends StatelessWidget {
  const ProductDetailReadyPage({super.key, required this.state});

  final ProductDetailReady state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailCubit>();
    final margin = $styles.grid.pageMargin;
    final insets = $styles.insets;
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                margin,
                insets.xs,
                margin,
                insets.lg,
              ),
              child: Column(
                children: [
                  ProductCard(
                    state: state,
                    onIncrement: cubit.increment,
                    onDecrement: cubit.decrement,
                  ),
                  insets.xl.toHeightSizedBox,
                  ProductDescription(description: state.product.description),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(margin, insets.xs, margin, insets.md),
            child: AddToCartButton(
              totalMmk: state.totalMmk,
              justAdded: state.justAdded,
              onPressed: cubit.addToCart,
            ),
          ),
        ],
      ),
    );
  }
}
