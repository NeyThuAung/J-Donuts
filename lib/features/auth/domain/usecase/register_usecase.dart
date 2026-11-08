import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/registration_request.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class RegisterUseCase implements UseCase<UserEntity, RegistrationRequest> {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<DataState<UserEntity>> call(RegistrationRequest param) =>
      guard(() => _repository.register(_tidy(param)));

  // Names are stored trimmed; a blank last name is no last name.
  RegistrationRequest _tidy(RegistrationRequest request) {
    final lastName = request.lastName?.trim();
    return RegistrationRequest(
      phone: request.phone,
      firstName: request.firstName.trim(),
      lastName: lastName == null || lastName.isEmpty ? null : lastName,
      dateOfBirth: request.dateOfBirth,
    );
  }
}
