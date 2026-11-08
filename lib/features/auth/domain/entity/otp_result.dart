import 'user_entity.dart';

sealed class OtpResult {
  const OtpResult();
}

/// The number belongs to a member; their session has started.
final class OtpSignedIn extends OtpResult {
  const OtpSignedIn(this.user);

  final UserEntity user;
}

/// A new number: continue with Name and Date of birth.
final class OtpNeedsRegistration extends OtpResult {
  const OtpNeedsRegistration();
}
