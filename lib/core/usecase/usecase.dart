import '../data_state/data_state.dart';

/// One-shot operation returning a [DataState].
abstract interface class UseCase<T, Param> {
  Future<DataState<T>> call(Param param);
}

/// Operation that keeps emitting, e.g. a Drift `watch()` query.
///
/// The cubit that listens owns the subscription and cancels it in `close()`.
abstract interface class StreamUseCase<T, Param> {
  Stream<DataState<T>> call(Param param);
}

/// Param for use cases that need no input.
final class NoParams {
  const NoParams();
}
