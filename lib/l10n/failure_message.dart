import '../core/core.dart';
import 'gen/app_localizations.dart';

// Feature-specific failures are mapped by their own widgets before this.
extension FailureMessageX on Failure {
  String message(AppLocalizations l10n) => switch (this) {
    ConnectionFailure() => l10n.errorNoConnection,
    TimeoutFailure() => l10n.errorTimeout,
    NotFoundFailure() => l10n.errorNotFound,
    BadRequestFailure() => l10n.errorBadRequest,
    SessionFailure() => l10n.errorSessionExpired,
    ServerFailure() => l10n.errorServer,
    CacheFailure() => l10n.errorStorage,
    _ => l10n.errorUnknown,
  };
}
