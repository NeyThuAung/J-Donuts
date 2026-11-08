import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/features/auth/presentation/cubit/authentication_cubit.dart';

void main() {
  group('AuthenticationCubit', () {
    test('starts unknown until the session has been checked', () {
      final cubit = AuthenticationCubit();
      addTearDown(cubit.close);

      expect(cubit.state, const AuthenticationState.unknown());
    });

    blocTest<AuthenticationCubit, AuthenticationState>(
      'checkSession reports signed out while no session is stored',
      build: AuthenticationCubit.new,
      act: (cubit) => cubit.checkSession(),
      expect: () => [const AuthenticationState.unauthenticated()],
    );
  });

  group('AuthenticationState', () {
    test('authenticated states with the same user are equal', () {
      expect(
        const AuthenticationState.authenticated(userId: 'u1'),
        const AuthenticationState.authenticated(userId: 'u1'),
      );
    });

    test('authenticated states with different users are not equal', () {
      expect(
        const AuthenticationState.authenticated(userId: 'u1'),
        isNot(const AuthenticationState.authenticated(userId: 'u2')),
      );
    });
  });
}
