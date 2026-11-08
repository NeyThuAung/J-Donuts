import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/onboarding/onboarding_page.dart';
import '../features/product/presentation/pages/product_detail/product_detail_page.dart';
import 'index_page.dart';
import 'index_tab.dart';

extension RouterExtension on BuildContext {
  void goOnboardingPage() => go(OnboardingPage.routePath);

  void goIndexPage() => go(IndexPage.routePath);

  void selectIndexTab(IndexTab tab) => go(
    Uri(
      path: IndexPage.routePath,
      queryParameters: {IndexTab.queryKey: tab.name},
    ).toString(),
  );

  // Pushed so the tab underneath stays as the user left it.
  Future<void> pushProductDetailPage({required String productId}) => push(
    Uri(
      pathSegments: ['', ProductDetailPage.routeName, productId],
    ).toString(),
  );
}
