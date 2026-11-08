part of 'authentication_cubit.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  // The session check has not finished yet.
  const factory AuthenticationState.unknown() = AuthenticationUnknown;

  const factory AuthenticationState.unauthenticated() =
      AuthenticationUnauthenticated;

  const factory AuthenticationState.authenticated({required String userId}) =
      Authenticated;
}
