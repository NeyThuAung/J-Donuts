// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get commonContinue => 'ဆက်လုပ်မည်';

  @override
  String get commonComingSoon => 'မကြာမီ လာမည်';

  @override
  String get commonRetry => 'ထပ်စမ်းကြည့်မည်';

  @override
  String get errorTitle => 'တစ်ခုခု မှားယွင်းနေပါသည်';

  @override
  String get errorNoConnection => 'အင်တာနက် ချိတ်ဆက်မှု မရှိပါ။';

  @override
  String get errorTimeout => 'ချိတ်ဆက်ချိန် ကုန်သွားပါပြီ။ ထပ်စမ်းကြည့်ပါ။';

  @override
  String get errorNotFound => 'ရှာမတွေ့ပါ။';

  @override
  String get errorBadRequest => 'တောင်းဆိုမှု မမှန်ကန်ပါ။';

  @override
  String get errorSessionExpired => 'အကောင့်ဝင်ချိန် ကုန်သွားပါပြီ။ ပြန်ဝင်ပါ။';

  @override
  String get errorServer =>
      'ဆာဗာတွင် ပြဿနာ ရှိနေပါသည်။ နောက်မှ ထပ်စမ်းကြည့်ပါ။';

  @override
  String get errorStorage => 'ဖုန်းထဲတွင် သိမ်းထားသော ဒေတာကို ဖတ်၍ မရပါ။';

  @override
  String get errorUnknown => 'တစ်ခုခု မှားယွင်းနေပါသည်။ ထပ်စမ်းကြည့်ပါ။';

  @override
  String get navHome => 'ပင်မ';

  @override
  String get navRewards => 'ဆုလာဘ်';

  @override
  String get navOrders => 'အော်ဒါများ';

  @override
  String get navWallet => 'ပိုက်ဆံအိတ်';

  @override
  String get navSettings => 'ဆက်တင်များ';

  @override
  String authStepProgress(int current, int total) {
    return 'အဆင့် $total ဆင့်အနက် $current';
  }

  @override
  String authTermsNotice(String terms, String privacy) {
    return 'ဆက်လုပ်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ $terms နှင့် $privacy ကို ဖတ်ရှုပြီး သဘောတူကြောင်း အသိအမှတ်ပြုပါသည်။';
  }

  @override
  String get authTermsOfUse => 'အသုံးပြုမှု စည်းမျဉ်းများ';

  @override
  String get authPrivacyPolicy => 'ကိုယ်ရေးအချက်အလက် မူဝါဒ';

  @override
  String get commonClose => 'ပိတ်ရန်';

  @override
  String get commonNotInDemo => 'ဤ demo တွင် မရရှိနိုင်သေးပါ။';

  @override
  String get authOnboardingTitle => 'စိတ်ခံစားမှုတိုင်းအတွက် အဝိုင်းလေးများ';

  @override
  String get authGetStarted => 'စတင်လိုက်ရအောင်';

  @override
  String get authHaveAccount => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get authLogIn => 'ဝင်ရောက်ရန်';

  @override
  String get authContinueWithGoogle => 'Google ဖြင့် ဆက်လုပ်ရန်';

  @override
  String get authContinueWithApple => 'Apple ဖြင့် ဆက်လုပ်ရန်';

  @override
  String get authContinueWithFacebook => 'Facebook ဖြင့် ဆက်လုပ်ရန်';

  @override
  String get authPhoneTitle => 'သင့်ဖုန်းနံပါတ်ကို ထည့်ပါ';

  @override
  String get authPhoneHint => '09 xxx xxx xxx';

  @override
  String get authPhoneErrorEmpty => 'ဖုန်းနံပါတ် ထည့်ပါ။';

  @override
  String get authPhoneErrorNotDigits => 'ဂဏန်းများသာ အသုံးပြုပါ။';

  @override
  String get authPhoneErrorWrongLeadingDigit =>
      'မြန်မာ မိုဘိုင်းနံပါတ်များသည် 09 ဖြင့် စတင်ပါသည်။';

  @override
  String get authPhoneErrorTooShort => 'ဤနံပါတ်သည် တိုလွန်းပါသည်။';

  @override
  String get authPhoneErrorTooLong => 'ဤနံပါတ်သည် ရှည်လွန်းပါသည်။';

  @override
  String get authPhoneNotRegistered => 'ဤနံပါတ်ဖြင့် စာရင်းမသွင်းရသေးပါ။';

  @override
  String get authPhoneRegisterInstead => 'စာရင်းသွင်းရန်';

  @override
  String get authPhoneAlreadyRegistered => 'ဤနံပါတ်ဖြင့် အကောင့်ရှိပြီးသားပါ။';

  @override
  String get authPhoneLogInInstead => 'ဝင်ရောက်ရန်';

  @override
  String get authOtpTitle => 'သင့်နံပါတ်ကို အတည်ပြုပါ';

  @override
  String authOtpSentTo(int length, String phone) {
    return '$phone သို့ ဂဏန်း $length လုံးပါ OTP ပို့ထားပါသည်';
  }

  @override
  String get authOtpCodeLabel => 'အတည်ပြုကုဒ်';

  @override
  String get authOtpNoCode => 'ကုဒ် မရရှိဘူးလား?';

  @override
  String authOtpResendIn(String time) {
    return '$time မိနစ်အတွင်း ပြန်ပို့နိုင်ပါမည်';
  }

  @override
  String get authOtpResend => 'ကုဒ် ပြန်ပို့ရန်';

  @override
  String get authOtpResent => 'ကုဒ်အသစ် ပို့ပေးလိုက်ပါပြီ။';

  @override
  String authOtpWrongCode(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ကုဒ် မှားနေပါသည်။ နောက်ထပ် $count ကြိမ် ကြိုးစားနိုင်ပါသည်။',
    );
    return '$_temp0';
  }

  @override
  String get authOtpLocked =>
      'ကုဒ်မှားသည့်အကြိမ် များလွန်းပါသည်။ ကုဒ်အသစ် ပြန်ပို့ပါ။';

  @override
  String get authNameTitle => 'သင့်အမည် ဘယ်လိုခေါ်လဲ?';

  @override
  String get authNameFirstHint => 'အမည်';

  @override
  String get authNameLastHint => 'မျိုးရိုးအမည်';

  @override
  String get authNameErrorEmpty => 'သင့်အမည်ကို ထည့်ပါ။';

  @override
  String authNameErrorTooLong(int max) {
    return 'စာလုံး $max လုံးထက် မပိုစေရ။';
  }

  @override
  String get authNameErrorDigits => 'အမည်တွင် ဂဏန်းများ မပါရပါ။';

  @override
  String get authNameErrorInvalid => 'စာလုံးနှင့် space သာ အသုံးပြုပါ။';

  @override
  String get commonDone => 'ပြီးပါပြီ';

  @override
  String get authDobTitle => 'သင့်မွေးနေ့ ဘယ်နေ့လဲ?';

  @override
  String get authDobMonth => 'လ';

  @override
  String get authDobDay => 'ရက်';

  @override
  String get authDobYear => 'ခုနှစ်';

  @override
  String get authDobErrorInvalid => 'ထိုရက်စွဲ မရှိပါ။';

  @override
  String get authDobErrorFuture => 'မွေးနေ့သည် အနာဂတ်ရက်စွဲ ဖြစ်၍ မရပါ။';

  @override
  String authDobErrorTooYoung(int age) {
    return 'အဖွဲ့ဝင်ရန် အသက် $age နှစ် အနည်းဆုံး ပြည့်ရပါမည်။';
  }

  @override
  String get authWelcomeTitle => 'J\'donuts ကမ္ဘာမှ ကြိုဆိုပါတယ်';

  @override
  String get authWelcomeExplore => 'စတင်ရှာဖွေမည်';

  @override
  String get commonCancel => 'မလုပ်တော့ပါ';

  @override
  String get commonOfflineBanner =>
      'အင်တာနက် မရှိပါ · သိမ်းထားသည့် အချက်အလက်ကို ပြသနေသည်';

  @override
  String get commonImageUnavailable => 'ပုံ မရနိုင်ပါ';

  @override
  String get settingsAccount => 'အကောင့်';

  @override
  String get settingsLogOut => 'ထွက်ရန်';

  @override
  String get settingsLogOutTitle => 'အကောင့်မှ ထွက်မလား?';

  @override
  String get settingsLogOutMessage =>
      'ပြန်ဝင်ရန် ဖုန်းနံပါတ်နှင့် ကုဒ် လိုအပ်ပါမည်။';

  @override
  String get memberTierSilver => 'ငွေ';

  @override
  String get memberTierGold => 'ရွှေ';

  @override
  String get memberTierPlatinum => 'ပလက်တီနမ်';

  @override
  String homeMemberTier(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String homePointsToNextTier(String points, String tier) {
    return '$tier အဖွဲ့ဝင် ဖြစ်ရန် $points မှတ် လိုပါသေးသည်';
  }

  @override
  String get homeTopTier => 'အမြင့်ဆုံး အဆင့်သို့ ရောက်ရှိနေပါပြီ';

  @override
  String homeNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'အသိပေးချက် $count ခု',
      zero: 'အသိပေးချက် မရှိပါ',
    );
    return '$_temp0';
  }

  @override
  String get homeNotificationsTitle => 'အသိပေးချက်များ';

  @override
  String get homeSeasonalSpecials => 'ရာသီအလိုက် အထူးများ';

  @override
  String get homePopular => 'လူကြိုက်များ 🔥';

  @override
  String get homeOrderAgain => 'ထပ်မံ မှာယူရန်';

  @override
  String homeSeeAll(String section) {
    return '$section အားလုံး ကြည့်ရန်';
  }

  @override
  String homeDiscountOff(int percent) {
    return '$percent% လျှော့';
  }

  @override
  String homeNearbyShops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'သင့်အနီးတွင် J\'Donut ဆိုင် $count ဆိုင် ရှိပါသည်။ 😋',
    );
    return '$_temp0';
  }

  @override
  String get homeExploreNow => 'ယခု လေ့လာမည်';

  @override
  String get homeOrderOnline => 'အွန်လိုင်းမှ မှာယူရန်';

  @override
  String get homeMemberEmpty => 'အဖွဲ့ဝင် အချက်အလက် မရရှိသေးပါ။';

  @override
  String get homeSectionEmpty => 'ဤနေရာတွင် မရှိသေးပါ။';

  @override
  String get homeSectionError => 'ဤအပိုင်းကို ဖွင့်၍ မရပါ။';

  @override
  String get productNew => 'အသစ်';

  @override
  String productPrice(String price) {
    return '$price ကျပ်';
  }

  @override
  String get productWhatsThis => 'ဒါဘာလဲ?';

  @override
  String get productAddToCart => 'ခြင်းထဲ ထည့်မည်';

  @override
  String get productAdded => 'ထည့်ပြီးပါပြီ';

  @override
  String productAddedMessage(int quantity, String name) {
    return '$name $quantity ခုကို ခြင်းထဲ ထည့်ပြီးပါပြီ။';
  }

  @override
  String get productDecrease => 'အရေအတွက် လျှော့ရန်';

  @override
  String get productIncrease => 'အရေအတွက် တိုးရန်';

  @override
  String productQuantity(int quantity) {
    return 'အရေအတွက် $quantity';
  }

  @override
  String get productNotFoundTitle => 'ဤပစ္စည်းကို ရှာမတွေ့ပါ';

  @override
  String get productNotFoundMessage => 'မီနူးမှ ဖယ်ရှားထားနိုင်ပါသည်။';
}
