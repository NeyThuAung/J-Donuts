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
}
