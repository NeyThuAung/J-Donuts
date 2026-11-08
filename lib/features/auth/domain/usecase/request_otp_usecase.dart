import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/auth_flow.dart';
import '../repository/auth_repository.dart';

class RequestOtpParam {
  const RequestOtpParam({required this.phone, required this.flow});

  final String phone;
  final AuthFlow flow;
}

/// Also used by Resend.
@lazySingleton
class RequestOtpUseCase implements UseCase<void, RequestOtpParam> {
  const RequestOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<DataState<void>> call(RequestOtpParam param) => guard(
    () => _repository.requestOtp(phone: param.phone, flow: param.flow),
  );
}
