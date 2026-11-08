import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/otp_result.dart';
import '../repository/auth_repository.dart';

class VerifyOtpParam {
  const VerifyOtpParam({required this.phone, required this.code});

  final String phone;
  final String code;
}

@lazySingleton
class VerifyOtpUseCase implements UseCase<OtpResult, VerifyOtpParam> {
  const VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<DataState<OtpResult>> call(VerifyOtpParam param) => guard(() async {
    final user = await _repository.verifyOtp(
      phone: param.phone,
      code: param.code,
    );
    return user == null ? const OtpNeedsRegistration() : OtpSignedIn(user);
  });
}
