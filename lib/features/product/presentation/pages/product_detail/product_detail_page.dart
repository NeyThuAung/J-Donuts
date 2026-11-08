import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';

// Placeholder until Task 2 builds the product detail screen.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  static const routeName = 'product';
  static const idParam = 'id';
  static const routePath = '$routeName/:$idParam';

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppErrorView(
        icon: CupertinoIcons.cart,
        message: context.l10n.commonComingSoon,
      ),
    );
  }
}
