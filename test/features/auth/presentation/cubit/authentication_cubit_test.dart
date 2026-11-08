import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/features/auth/domain/entity/user_entity.dart';
import 'package:j_donuts/features/auth/domain/usecase/check_session_usecase.dart';
import 'package:j_donuts/features/auth/domain/usecase/log_out_usecase.dart';
import 'package:j_donuts/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:mocktail/mocktail.dart';

class _MockCheckSession extends Mock implements CheckSessionUseCase {}

class _MockLogOut extends Mock implements LogOutUseCase {}

class _MockSnackShower extends Mock implements ISnackShower {}

const _noParams = NoParams();
const _signedOut = AuthenticationState.unauthenticated();
final _user = UserEntity(
  id: '7',
  phone: '+959254135592',
  firstName: 'Ye Min',
  dateOfBirth: DateTime(1980, 5),
);

void main() {
  late _MockCheckSession checkSession;
  late _MockLogOut logOut;
  late _MockSnackShower snack;

  setUpAll(() => registerFallbackValue(const CacheFailure()));

  setUp(() {
    checkSession = _MockCheckSession();
    logOut = _MockLogOut();
    snack = _MockSnackShower();
  });

  AuthenticationCubit build() =>
      AuthenticationCubit(checkSession, logOut, snack);

  void whenSession(DataState<UserEntity?> result) =>
      when(() => checkSession(_noParams)).thenAnswer((_) async => result);

  group('AuthenticationCubit', () {
    test('starts unknown until the session has been checked', () {
      final cubit = build();
      addTearDown(cubit.close);

      expect(cubit.state, const AuthenticationState.unknown());
    });

    blocTest<AuthenticationCubit, AuthenticationState>(
      'checkSession signs in the stored member as a returning member',
      setUp: () => whenSession(Success(_user)),
      build: build,
      act: (cubit) => cubit.checkSession(),
      expect: () => [const AuthenticationState.authenticated(userId: '7')],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'checkSession reports signed out when no session is stored',
      setUp: () => whenSession(const Success(null)),
      build: build,
      act: (cubit) => cubit.checkSession(),
      expect: () => [_signedOut],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'checkSession treats an unreadable session as signed out',
      setUp: () => whenSession(const Failed(CacheFailure())),
      build: build,
      act: (cubit) => cubit.checkSession(),
      expect: () => [_signedOut],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'signedIn marks a just-registered member as new',
      build: build,
      act: (cubit) => cubit.signedIn(_user, isNewMember: true),
      expect: () => [
        const AuthenticationState.authenticated(userId: '7', isNewMember: true),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'welcomeSeen turns a new member into a returning one',
      build: build,
      seed: () => const AuthenticationState.authenticated(
        userId: '7',
        isNewMember: true,
      ),
      act: (cubit) => cubit.welcomeSeen(),
      expect: () => [const AuthenticationState.authenticated(userId: '7')],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'welcomeSeen does nothing for a returning member',
      build: build,
      seed: () => const AuthenticationState.authenticated(userId: '7'),
      act: (cubit) => cubit.welcomeSeen(),
      expect: () => <AuthenticationState>[],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'logOut signs the member out',
      setUp: () => when(
        () => logOut(_noParams),
      ).thenAnswer((_) async => const Success<void>(null)),
      build: build,
      seed: () => const AuthenticationState.authenticated(userId: '7'),
      act: (cubit) => cubit.logOut(),
      expect: () => [_signedOut],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'logOut keeps the session and shows the error when it fails',
      setUp: () => when(
        () => logOut(_noParams),
      ).thenAnswer((_) async => const Failed<void>(CacheFailure())),
      build: build,
      seed: () => const AuthenticationState.authenticated(userId: '7'),
      act: (cubit) => cubit.logOut(),
      expect: () => <AuthenticationState>[],
      verify: (_) => verify(() => snack.error(const CacheFailure())).called(1),
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

    test('a returning member is not new by default', () {
      expect(
        const AuthenticationState.authenticated(userId: 'u1'),
        isA<Authenticated>().having((s) => s.isNewMember, 'isNewMember', false),
      );
    });
  });
}
