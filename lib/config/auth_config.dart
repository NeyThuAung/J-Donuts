// Fake auth backend; a real API replaces FakeAuthRepository, not these screens.
abstract final class AuthConfig {
  static const fakeOtpCode = '123456';
  static const fakeLatency = Duration(seconds: 1);
}
