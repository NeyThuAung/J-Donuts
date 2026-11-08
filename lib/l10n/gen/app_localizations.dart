import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'J\'Donuts'**
  String get appTitle;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get commonComingSoon;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get errorNoConnection;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The connection timed out. Please try again.'**
  String get errorTimeout;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find that.'**
  String get errorNotFound;

  /// No description provided for @errorBadRequest.
  ///
  /// In en, this message translates to:
  /// **'Something in the request wasn\'t right.'**
  String get errorBadRequest;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get errorSessionExpired;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Our server is having trouble. Please try again later.'**
  String get errorServer;

  /// No description provided for @errorStorage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read the data saved on this phone.'**
  String get errorStorage;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navRewards.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get navRewards;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get navWallet;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Screen reader label of the sign-up progress ring.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String authStepProgress(int current, int total);

  /// Footer of the sign-up screens; {terms} and {privacy} become links.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our {terms} and {privacy}.'**
  String authTermsNotice(String terms, String privacy);

  /// No description provided for @authTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get authTermsOfUse;

  /// No description provided for @authPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get authPrivacyPolicy;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonNotInDemo.
  ///
  /// In en, this message translates to:
  /// **'This isn\'t available in the demo yet.'**
  String get commonNotInDemo;

  /// No description provided for @authOnboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Round food for every mood'**
  String get authOnboardingTitle;

  /// No description provided for @authGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started'**
  String get authGetStarted;

  /// No description provided for @authHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authHaveAccount;

  /// No description provided for @authLogIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get authLogIn;

  /// No description provided for @authContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueWithGoogle;

  /// No description provided for @authContinueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authContinueWithApple;

  /// No description provided for @authContinueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get authContinueWithFacebook;

  /// No description provided for @authPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get authPhoneTitle;

  /// No description provided for @authPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'09 xxx xxx xxx'**
  String get authPhoneHint;

  /// No description provided for @authPhoneErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number.'**
  String get authPhoneErrorEmpty;

  /// No description provided for @authPhoneErrorNotDigits.
  ///
  /// In en, this message translates to:
  /// **'Use numbers only.'**
  String get authPhoneErrorNotDigits;

  /// No description provided for @authPhoneErrorWrongLeadingDigit.
  ///
  /// In en, this message translates to:
  /// **'Myanmar mobile numbers start with 09.'**
  String get authPhoneErrorWrongLeadingDigit;

  /// No description provided for @authPhoneErrorTooShort.
  ///
  /// In en, this message translates to:
  /// **'This number is too short.'**
  String get authPhoneErrorTooShort;

  /// No description provided for @authPhoneErrorTooLong.
  ///
  /// In en, this message translates to:
  /// **'This number is too long.'**
  String get authPhoneErrorTooLong;

  /// No description provided for @authPhoneNotRegistered.
  ///
  /// In en, this message translates to:
  /// **'This number isn\'t registered yet.'**
  String get authPhoneNotRegistered;

  /// No description provided for @authPhoneRegisterInstead.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authPhoneRegisterInstead;

  /// No description provided for @authPhoneAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This number already has an account.'**
  String get authPhoneAlreadyRegistered;

  /// No description provided for @authPhoneLogInInstead.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get authPhoneLogInInstead;

  /// No description provided for @authOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get authOtpTitle;

  /// No description provided for @authOtpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent {length} digit OTP to {phone}'**
  String authOtpSentTo(int length, String phone);

  /// No description provided for @authOtpCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get authOtpCodeLabel;

  /// No description provided for @authOtpNoCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get authOtpNoCode;

  /// {time} is shown highlighted, e.g. 4:58.
  ///
  /// In en, this message translates to:
  /// **'resend in {time} min'**
  String authOtpResendIn(String time);

  /// No description provided for @authOtpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get authOtpResend;

  /// No description provided for @authOtpResent.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you a new code.'**
  String get authOtpResent;

  /// No description provided for @authOtpWrongCode.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{That code isn\'t right. 1 try left.} other{That code isn\'t right. {count} tries left.}}'**
  String authOtpWrongCode(int count);

  /// No description provided for @authOtpLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many wrong codes. Resend to get a new one.'**
  String get authOtpLocked;

  /// No description provided for @authNameTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your name?'**
  String get authNameTitle;

  /// No description provided for @authNameFirstHint.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get authNameFirstHint;

  /// No description provided for @authNameLastHint.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get authNameLastHint;

  /// No description provided for @authNameErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name.'**
  String get authNameErrorEmpty;

  /// No description provided for @authNameErrorTooLong.
  ///
  /// In en, this message translates to:
  /// **'Use {max} characters or fewer.'**
  String authNameErrorTooLong(int max);

  /// No description provided for @authNameErrorDigits.
  ///
  /// In en, this message translates to:
  /// **'Names can\'t contain numbers.'**
  String get authNameErrorDigits;

  /// No description provided for @authNameErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use letters and spaces only.'**
  String get authNameErrorInvalid;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @authDobTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your date of birth?'**
  String get authDobTitle;

  /// No description provided for @authDobMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get authDobMonth;

  /// No description provided for @authDobDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get authDobDay;

  /// No description provided for @authDobYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get authDobYear;

  /// No description provided for @authDobErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'That date doesn\'t exist.'**
  String get authDobErrorInvalid;

  /// No description provided for @authDobErrorFuture.
  ///
  /// In en, this message translates to:
  /// **'Your date of birth can\'t be in the future.'**
  String get authDobErrorFuture;

  /// No description provided for @authDobErrorTooYoung.
  ///
  /// In en, this message translates to:
  /// **'You need to be at least {age} years old to join.'**
  String authDobErrorTooYoung(int age);

  /// No description provided for @authWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the world of J\'donuts'**
  String get authWelcomeTitle;

  /// No description provided for @authWelcomeExplore.
  ///
  /// In en, this message translates to:
  /// **'Let\'s explore'**
  String get authWelcomeExplore;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
