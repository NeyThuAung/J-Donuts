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

const testUserId = 'u1';

/// For router and app tests: checkSession finds no session, and the test
/// moves the session with [signIn] / [signOut].
class TestAuthenticationCubit extends AuthenticationCubit {
  TestAuthenticationCubit()
    : super(_signedOutSession(), _MockLogOut(), _MockSnackShower());

  void signIn({bool isNewMember = false}) => emit(
    AuthenticationState.authenticated(
      userId: testUserId,
      isNewMember: isNewMember,
    ),
  );

  void signOut() => emit(const AuthenticationState.unauthenticated());

  static CheckSessionUseCase _signedOutSession() {
    final checkSession = _MockCheckSession();
    when(
      () => checkSession(const NoParams()),
    ).thenAnswer((_) async => const Success<UserEntity?>(null));
    return checkSession;
  }
}
