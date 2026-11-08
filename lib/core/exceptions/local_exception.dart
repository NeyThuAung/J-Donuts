import '../failures/app_failure.dart';
import '../failures/failure.dart';
import 'app_exception.dart';

/// Thrown by repositories when Drift or secure storage fails.
final class LocalException extends AppException {
  const LocalException(super.message, [super.code]);

  @override
  Failure toFailure() => CacheFailure(message);
}
