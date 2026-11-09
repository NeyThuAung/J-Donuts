import '../network/api_envelope.dart';

/// Saves [envelope]'s data when nothing is stored yet or its version is
/// newer. Used for the bundled seed and for refreshes from the API.
/// Returns whether anything was written.
Future<bool> saveIfNewer<T>(
  ApiEnvelope<T> envelope, {
  required Future<int?> Function() storedVersion,
  required Future<void> Function(T data, int version) save,
}) async {
  final stored = await storedVersion();
  final version = envelope.meta.version;
  if (stored != null && version <= stored) return false;
  await save(envelope.requireData(), version);
  return true;
}
