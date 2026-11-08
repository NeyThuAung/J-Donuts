import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

// App-wide session state; the router's auth guard follows it.
@lazySingleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState.unknown());

  // Stub: Task 1 reads the saved session from secure storage here.
  Future<void> checkSession() async {
    emit(const AuthenticationState.unauthenticated());
  }
}
