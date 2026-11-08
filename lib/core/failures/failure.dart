/// [reason] is for logs; widgets map the failure type to l10n text.
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
