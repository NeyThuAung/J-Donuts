import '../data_state/data_state.dart';

abstract interface class UseCase<T, Param> {
  Future<DataState<T>> call(Param param);
}

/// The listening cubit cancels its subscription in `close()`.
abstract interface class StreamUseCase<T, Param> {
  Stream<DataState<T>> call(Param param);
}

final class NoParams {
  const NoParams();
}
