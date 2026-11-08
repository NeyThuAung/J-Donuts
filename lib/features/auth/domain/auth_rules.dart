abstract final class AuthRules {
  static const countryCode = '+95';
  static const phoneLeadingDigit = '9';
  static const phoneMinDigitsAfterLeading = 7;
  static const phoneMaxDigitsAfterLeading = 9;

  static const otpLength = 6;
  static const maxOtpAttempts = 3;
  static const resendCountdown = Duration(minutes: 5);

  static const nameMaxLength = 50;

  static const minimumAge = 13;
}
