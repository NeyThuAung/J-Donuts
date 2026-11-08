import '../failures/failure.dart';

/// Result of a use case: either [Success] with data or [Failed] with a
/// [Failure]. Callers branch with `switch` or `onSuccess` / `onError`.
sealed class DataState<T> {
  const DataState();

  /// The data when this is a [Success], otherwise null.
  T? get dataOrNull => switch (this) {
    Success<T>(:final data) => data,
    Failed<T>() => null,
  };

  R? onSuccess<R>(R? Function(T data) handler) => switch (this) {
    Success<T>(:final data) => handler(data),
    Failed<T>() => null,
  };

  R? onError<R>(R? Function(Failure failure) handler) => switch (this) {
    Success<T>() => null,
    Failed<T>(:final failure) => handler(failure),
  };
}

final class Success<T> extends DataState<T> {
  const Success(this.data);

  final T data;

  @override
  bool operator ==(Object other) => other is Success<T> && other.data == data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success($data)';
}

final class Failed<T> extends DataState<T> {
  const Failed(this.failure, [this.error]);

  final Failure failure;

  /// The original error, kept for logging only.
  final Object? error;

  @override
  bool operator ==(Object other) =>
      other is Failed<T> && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;

  @override
  String toString() => 'Failed($failure)';
}
