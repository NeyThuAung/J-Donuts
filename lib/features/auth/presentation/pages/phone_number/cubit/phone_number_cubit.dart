import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/core.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../domain/entity/auth_flow.dart';
import '../../../../domain/failure/auth_failure.dart';
import '../../../../domain/usecase/request_otp_usecase.dart';
import '../../../../domain/validators/validators.dart';

part 'phone_number_cubit.freezed.dart';
part 'phone_number_state.dart';

@injectable
class PhoneNumberCubit extends Cubit<PhoneNumberState> {
  PhoneNumberCubit(this._requestOtp, this._snack)
    : super(const PhoneNumberState());

  final RequestOtpUseCase _requestOtp;
  final ISnackShower _snack;

  final phoneController = TextEditingController();

  void start(AuthFlow flow) => emit(state.copyWith(flow: flow));

  void phoneChanged(String input) => emit(
    state.copyWith(validationError: validatePhone(input), isWrongFlow: false),
  );

  void fieldLeft() => emit(state.copyWith(showValidationError: true));

  /// Ignored while a request is running, so a double tap sends one request.
  Future<void> submit() async {
    if (state.isSubmitting) return;
    if (state.validationError != null) {
      fieldLeft();
      return;
    }
    final phone = normalizePhone(phoneController.text);
    emit(
      state.copyWith(isSubmitting: true, isWrongFlow: false, otpSentTo: null),
    );
    final result = await _requestOtp(
      RequestOtpParam(phone: phone, flow: state.flow),
    );
    if (isClosed) return;
    result
      ..onSuccess(
        (_) => emit(state.copyWith(isSubmitting: false, otpSentTo: phone)),
      )
      ..onError(_onError);
  }

  /// The inline link: same number, other flow, sent at once.
  Future<void> switchFlow() {
    final other = state.flow == AuthFlow.logIn
        ? AuthFlow.register
        : AuthFlow.logIn;
    emit(state.copyWith(flow: other, isWrongFlow: false));
    return submit();
  }

  void _onError(Failure failure) {
    final isWrongFlow =
        failure is PhoneNotRegisteredFailure ||
        failure is PhoneAlreadyRegisteredFailure;
    emit(state.copyWith(isSubmitting: false, isWrongFlow: isWrongFlow));
    if (!isWrongFlow) _snack.error(failure);
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
