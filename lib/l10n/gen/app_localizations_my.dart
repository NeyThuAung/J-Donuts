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
}
