import '../failures/app_failure.dart';
import '../failures/failure.dart';
import 'app_exception.dart';

final class LocalException extends AppException {
  const LocalException(super.message, [super.code]);

  @override
  Failure toFailure() => CacheFailure(message);
}
