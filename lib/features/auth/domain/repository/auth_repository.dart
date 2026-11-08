import '../entity/auth_flow.dart';
import '../entity/registration_request.dart';
import '../entity/user_entity.dart';

/// A real API can replace the fake implementation without touching the UI.
/// Phones are normalized (+959…).
abstract interface class AuthRepository {
  /// Log-in needs a registered phone; register needs a new one.
  Future<void> requestOtp({required String phone, required AuthFlow flow});

  /// Returns the member and starts their session, or null for a new number.
  Future<UserEntity?> verifyOtp({required String phone, required String code});

  /// Needs a phone verified by [verifyOtp]; starts the new member's session.
  Future<UserEntity> register(RegistrationRequest request);

  Future<UserEntity?> currentUser();

  Future<void> logOut();
}
