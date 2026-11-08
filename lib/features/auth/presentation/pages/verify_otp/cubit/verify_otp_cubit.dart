import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../domain/auth_rules.dart';
import '../../../../domain/entity/auth_flow.dart';
import '../../../../domain/entity/otp_result.dart';
import '../../../../domain/failure/auth_failure.dart';
import '../../../../domain/usecase/request_otp_usecase.dart';
import '../../../../domain/usecase/verify_otp_usecase.dart';
import '../../../../domain/validators/validators.dart';

part 'verify_otp_cubit.freezed.dart';
part 'verify_otp_state.dart';

const _tick = Duration(seconds: 1);

@injectable
class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit(this._verifyOtp, this._requestOtp, this._snack)
    : super(const VerifyOtpState());

  final VerifyOtpUseCase _verifyOtp;
  final RequestOtpUseCase _requestOtp;
  final ISnackShower _snack;

  final codeController = TextEditingController();
  Timer? _countdown;

  /// The Phone step has just sent the first code.
  void start({required String phone, required AuthFlow flow}) {
    emit(state.copyWith(phone: phone, flow: flow));
    _startCountdown();
  }

  /// Verifies as soon as all digits are in.
  void codeChanged(String code) {
    if (state.showWrongCode) emit(state.copyWith(showWrongCode: false));
    if (validateOtp(code) == null) unawaited(_verify(code));
  }

  /// Back from the Name step: the code stays, and editing it verifies again.
  void resumed() => emit(state.copyWith(result: null));

  Future<void> resend() async {
    if (!state.canResend) return;
    emit(state.copyWith(isResending: true));
    final result = await _requestOtp(
      RequestOtpParam(phone: state.phone, flow: state.flow),
    );
    if (isClosed) return;
    result
      ..onSuccess((_) => _onResent())
      ..onError((failure) {
        emit(state.copyWith(isResending: false));
        _snack.error(failure);
      });
  }

  Future<void> _verify(String code) async {
    if (!state.canType) return;
    emit(state.copyWith(isVerifying: true));
    final result = await _verifyOtp(
      VerifyOtpParam(phone: state.phone, code: code),
    );
    if (isClosed) return;
    result
      ..onSuccess(_onVerified)
      ..onError(_onVerifyFailed);
  }

  void _onVerified(OtpResult result) {
    _countdown?.cancel();
    emit(state.copyWith(isVerifying: false, result: result));
  }

  void _onVerifyFailed(Failure failure) {
    if (failure is! InvalidOtpFailure) {
      emit(state.copyWith(isVerifying: false));
      _snack.error(failure);
      return;
    }
    codeController.clear();
    final wrongAttempts = state.wrongAttempts + 1;
    final isLocked = wrongAttempts >= AuthRules.maxOtpAttempts;
    // Locked: Resend opens at once instead of after the countdown.
    if (isLocked) _countdown?.cancel();
    emit(
      state.copyWith(
        isVerifying: false,
        wrongAttempts: wrongAttempts,
        showWrongCode: true,
        shakeCount: state.shakeCount + 1,
        resendIn: isLocked ? Duration.zero : state.resendIn,
      ),
    );
  }

  void _onResent() {
    codeController.clear();
    emit(
      state.copyWith(
        isResending: false,
        wrongAttempts: 0,
        showWrongCode: false,
        resendIn: AuthRules.resendCountdown,
      ),
    );
    _startCountdown();
    _snack.info((l10n) => l10n.authOtpResent);
  }

  void _startCountdown() {
    _countdown?.cancel();
    _countdown = Timer.periodic(_tick, (_) => _onTick());
  }

  void _onTick() {
    final remaining = state.resendIn - _tick;
    if (remaining <= Duration.zero) _countdown?.cancel();
    emit(
      state.copyWith(
        resendIn: remaining < Duration.zero ? Duration.zero : remaining,
      ),
    );
  }

  @override
  Future<void> close() {
    _countdown?.cancel();
    codeController.dispose();
    return super.close();
  }
}
