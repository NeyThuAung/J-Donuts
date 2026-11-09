import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/extensions/extensions.dart';
import '../../../../../shared/styles/styles.dart';
import 'cubit/product_detail_cubit.dart';
import 'widget/product_detail_ready_page.dart';
import 'widget/sub/product_detail_skeleton.dart';

// Screen 9; the route provides ProductDetailCubit for [productId].
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId, this.heroFrom});

  static const routeName = 'product';
  static const idParam = 'id';
  static const fromParam = 'from';
  static const routePath = '$routeName/:$idParam';

  final String productId;

  /// Where the user tapped the product (a Home section); null: no Hero.
  final String? heroFrom;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: colors.background,
        systemOverlayStyle: context.systemOverlayStyle,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: context.motion(AppMotion.fieldState),
          child: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, ProductDetailState state) {
    final l10n = context.l10n;
    return switch (state) {
      ProductDetailLoading() => const ProductDetailSkeleton(),
      ProductDetailReady() => ProductDetailReadyPage(
        state: state,
        heroTag: _heroTag,
      ),
      ProductDetailNotFound() => AppErrorView(
        icon: CupertinoIcons.search,
        title: l10n.productNotFoundTitle,
        message: l10n.productNotFoundMessage,
      ),
      ProductDetailError(:final failure) => AppErrorView(
        message: failure.message(l10n),
        onRetry: context.read<ProductDetailCubit>().retry,
      ),
    };
  }

  String? get _heroTag {
    final from = heroFrom;
    return from == null ? null : HeroTags.product(from: from, id: productId);
  }
}
