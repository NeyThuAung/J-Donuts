/// A user-presentable outcome of a failed operation.
///
/// [reason] is a developer-facing description for logs and tests. Widgets
/// never show it directly; they map the failure type to localized text.
abstract class Failure {
  const Failure(this.reason);

  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other.runtimeType == runtimeType &&
          other is Failure &&
          other.reason == reason;

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  @override
  String toString() => '$runtimeType($reason)';
}
