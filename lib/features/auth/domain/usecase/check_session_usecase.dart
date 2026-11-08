import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

/// Success(null) means signed out.
@lazySingleton
class CheckSessionUseCase implements UseCase<UserEntity?, NoParams> {
  const CheckSessionUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<DataState<UserEntity?>> call(NoParams param) =>
      guard(_repository.currentUser);
}
