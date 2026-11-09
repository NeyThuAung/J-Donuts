part of 'authentication_cubit.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.unknown() = AuthenticationUnknown;

  const factory AuthenticationState.unauthenticated() =
      AuthenticationUnauthenticated;

  const factory AuthenticationState.authenticated({
    required String userId,
    @Default(false) bool isNewMember,
  }) = Authenticated;
}
