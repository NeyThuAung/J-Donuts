import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../../shared/components/components.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/check_session_usecase.dart';
import '../../domain/usecase/log_out_usecase.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

// App-wide session state; the router's auth guard follows it.
@lazySingleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._checkSession, this._logOut, this._snack)
    : super(const AuthenticationState.unknown());

  final CheckSessionUseCase _checkSession;
  final LogOutUseCase _logOut;
  final ISnackShower _snack;

  /// Runs before the first frame. An unreadable session counts as signed out.
  Future<void> checkSession() async {
    final result = await _checkSession(const NoParams());
    if (isClosed) return;
    final user = result.dataOrNull;
    emit(
      user == null
          ? const AuthenticationState.unauthenticated()
          : AuthenticationState.authenticated(userId: user.id),
    );
  }

  /// Called by the OTP (log in) and Date of birth (register) steps.
  void signedIn(UserEntity user, {bool isNewMember = false}) => emit(
    AuthenticationState.authenticated(
      userId: user.id,
      isNewMember: isNewMember,
    ),
  );

  void welcomeSeen() {
    final current = state;
    if (current is Authenticated && current.isNewMember) {
      emit(current.copyWith(isNewMember: false));
    }
  }

  Future<void> logOut() async {
    final result = await _logOut(const NoParams());
    if (isClosed) return;
    result
      ..onSuccess((_) => emit(const AuthenticationState.unauthenticated()))
      ..onError(_snack.error);
  }
}
