import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/domain/entity/auth_flow.dart';
import '../features/auth/presentation/pages/date_of_birth/date_of_birth_page.dart';
import '../features/auth/presentation/pages/name/name_page.dart';
import '../features/auth/presentation/pages/onboarding/onboarding_page.dart';
import '../features/auth/presentation/pages/phone_number/phone_number_page.dart';
import '../features/auth/presentation/pages/verify_otp/verify_otp_page.dart';
import '../features/product/presentation/pages/product_detail/product_detail_page.dart';
import 'index_page.dart';
import 'index_tab.dart';

// Auth steps are pushed so Back returns to the previous step with its input.
// Leaving the flow (to Welcome or Home) is the router's redirect, not a helper.
extension RouterExtension on BuildContext {
  void goOnboardingPage() => go(OnboardingPage.routePath);

  Future<void> pushPhoneNumberPage({required AuthFlow flow}) => push(
    Uri(
      path: PhoneNumberPage.routePath,
      queryParameters: {PhoneNumberPage.flowParam: flow.name},
    ).toString(),
  );

  Future<void> pushVerifyOtpPage(VerifyOtpArgs args) =>
      push(VerifyOtpPage.routePath, extra: args);

  Future<void> pushNamePage(NameArgs args) =>
      push(NamePage.routePath, extra: args);

  Future<void> pushDateOfBirthPage(DateOfBirthArgs args) =>
      push(DateOfBirthPage.routePath, extra: args);

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
