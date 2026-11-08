import 'package:injectable/injectable.dart';

import '../../../../core/data_state/data_state.dart';
import '../../../../core/usecase/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class LogOutUseCase implements UseCase<void, NoParams> {
  const LogOutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<DataState<void>> call(NoParams param) => guard(_repository.logOut);
}
