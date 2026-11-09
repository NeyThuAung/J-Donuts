// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonComingSoon => 'Coming soon';

  @override
  String get commonRetry => 'Retry';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorNoConnection => 'No internet connection.';

  @override
  String get errorTimeout => 'The connection timed out. Please try again.';

  @override
  String get errorNotFound => 'We couldn\'t find that.';

  @override
  String get errorBadRequest => 'Something in the request wasn\'t right.';

  @override
  String get errorSessionExpired =>
      'Your session has expired. Please log in again.';

  @override
  String get errorServer =>
      'Our server is having trouble. Please try again later.';

  @override
  String get errorStorage => 'We couldn\'t read the data saved on this phone.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get navHome => 'Home';

  @override
  String get navRewards => 'Reward';

  @override
  String get navOrders => 'Orders';

  @override
  String get navWallet => 'Wallet';

  @override
  String get navSettings => 'Settings';

  @override
  String authStepProgress(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String authTermsNotice(String terms, String privacy) {
    return 'By continuing, you acknowledge that you have read and agree to our $terms and $privacy.';
  }

  @override
  String get authTermsOfUse => 'Terms of Use';

  @override
  String get authPrivacyPolicy => 'Privacy Policy';

  @override
  String get commonClose => 'Close';

  @override
  String get commonNotInDemo => 'This isn\'t available in the demo yet.';

  @override
  String get authOnboardingTitle => 'Round food for every mood';

  @override
  String get authGetStarted => 'Let\'s get started';

  @override
  String get authHaveAccount => 'Already have an account?';

  @override
  String get authLogIn => 'Log In';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authContinueWithApple => 'Continue with Apple';

  @override
  String get authContinueWithFacebook => 'Continue with Facebook';

  @override
  String get authPhoneTitle => 'Enter your phone number';

  @override
  String get authPhoneHint => '09 xxx xxx xxx';

  @override
  String get authPhoneErrorEmpty => 'Enter your phone number.';

  @override
  String get authPhoneErrorNotDigits => 'Use numbers only.';

  @override
  String get authPhoneErrorWrongLeadingDigit =>
      'Myanmar mobile numbers start with 09.';

  @override
  String get authPhoneErrorTooShort => 'This number is too short.';

  @override
  String get authPhoneErrorTooLong => 'This number is too long.';

  @override
  String get authPhoneNotRegistered => 'This number isn\'t registered yet.';

  @override
  String get authPhoneRegisterInstead => 'Register';

  @override
  String get authPhoneAlreadyRegistered =>
      'This number already has an account.';

  @override
  String get authPhoneLogInInstead => 'Log in';

  @override
  String get authOtpTitle => 'Verify your number';

  @override
  String authOtpSentTo(int length, String phone) {
    return 'We\'ve sent $length digit OTP to $phone';
  }

  @override
  String get authOtpCodeLabel => 'Verification code';

  @override
  String get authOtpNoCode => 'Didn\'t receive the code?';

  @override
  String authOtpResendIn(String time) {
    return 'resend in $time min';
  }

  @override
  String get authOtpResend => 'Resend code';

  @override
  String get authOtpResent => 'We\'ve sent you a new code.';

  @override
  String authOtpWrongCode(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'That code isn\'t right. $count tries left.',
      one: 'That code isn\'t right. 1 try left.',
    );
    return '$_temp0';
  }

  @override
  String get authOtpLocked => 'Too many wrong codes. Resend to get a new one.';

  @override
  String get authNameTitle => 'What\'s your name?';

  @override
  String get authNameFirstHint => 'First Name';

  @override
  String get authNameLastHint => 'Last Name';

  @override
  String get authNameErrorEmpty => 'Enter your first name.';

  @override
  String authNameErrorTooLong(int max) {
    return 'Use $max characters or fewer.';
  }

  @override
  String get authNameErrorDigits => 'Names can\'t contain numbers.';

  @override
  String get authNameErrorInvalid => 'Use letters and spaces only.';

  @override
  String get commonDone => 'Done';

  @override
  String get authDobTitle => 'What\'s your date of birth?';

  @override
  String get authDobMonth => 'Month';

  @override
  String get authDobDay => 'Day';

  @override
  String get authDobYear => 'Year';

  @override
  String get authDobErrorInvalid => 'That date doesn\'t exist.';

  @override
  String get authDobErrorFuture =>
      'Your date of birth can\'t be in the future.';

  @override
  String authDobErrorTooYoung(int age) {
    return 'You need to be at least $age years old to join.';
  }

  @override
  String get authWelcomeTitle => 'Welcome to the world of J\'donuts';

  @override
  String get authWelcomeExplore => 'Let\'s explore';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonOfflineBanner => 'You\'re offline · showing saved data';

  @override
  String get commonImageUnavailable => 'Image unavailable';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsLogOut => 'Log out';

  @override
  String get settingsLogOutTitle => 'Log out?';

  @override
  String get settingsLogOutMessage =>
      'You\'ll need your phone number and a code to log back in.';

  @override
  String get memberTierSilver => 'Silver';

  @override
  String get memberTierGold => 'Gold';

  @override
  String get memberTierPlatinum => 'Platinum';

  @override
  String homeMemberTier(String tier) {
    return '$tier member';
  }

  @override
  String homePointsToNextTier(String points, String tier) {
    return '$points points left to become $tier Member';
  }

  @override
  String get homeTopTier => 'You\'re at our top tier';

  @override
  String homeNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notifications',
      one: '1 notification',
      zero: 'No notifications',
    );
    return '$_temp0';
  }

  @override
  String get homeNotificationsTitle => 'Notifications';

  @override
  String get homeSeasonalSpecials => 'Seasonal specials';

  @override
  String get homePopular => 'Popular 🔥';

  @override
  String get homeOrderAgain => 'Order again';

  @override
  String homeSeeAll(String section) {
    return 'See all $section';
  }

  @override
  String homeDiscountOff(int percent) {
    return '$percent% off';
  }

  @override
  String homeNearbyShops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'There are $count J\'Donut shops near you. 😋',
      one: 'There is 1 J\'Donut shop near you. 😋',
    );
    return '$_temp0';
  }

  @override
  String get homeExploreNow => 'Explore now';

  @override
  String get homeOrderOnline => 'Order online';

  @override
  String get homeMemberEmpty => 'Your member details aren\'t ready yet.';

  @override
  String get homeSectionEmpty => 'Nothing here yet.';

  @override
  String get homeSectionError => 'We couldn\'t load this part.';

  @override
  String get productNew => 'New';

  @override
  String productPrice(String price) {
    return '$price MMK';
  }

  @override
  String get productWhatsThis => 'What\'s this?';

  @override
  String get productAddToCart => 'Add to cart';

  @override
  String get productAdded => 'Added';

  @override
  String productAddedMessage(int quantity, String name) {
    return '$quantity × $name added to your cart.';
  }

  @override
  String get productDecrease => 'Decrease quantity';

  @override
  String get productIncrease => 'Increase quantity';

  @override
  String productQuantity(int quantity) {
    return 'Quantity $quantity';
  }

  @override
  String get productNotFoundTitle => 'We couldn\'t find this product';

  @override
  String get productNotFoundMessage => 'It may have been taken off the menu.';
}
