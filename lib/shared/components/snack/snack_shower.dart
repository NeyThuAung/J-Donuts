import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../../../l10n/l10n.dart';
import '../../../navigation/navigation_key_provider.dart';
import 'app_snack.dart';

typedef L10nMessage = String Function(AppLocalizations l10n);

// Lets cubits show a snack without a BuildContext; text is resolved from the
// root navigator's context so it follows the current locale.
abstract interface class ISnackShower {
  void info(L10nMessage message);

  void success(L10nMessage message);

  void error(Failure failure);
}

@LazySingleton(as: ISnackShower)
class SnackShower implements ISnackShower {
  const SnackShower(this._keyProvider);

  final INavigationKeyProvider _keyProvider;

  @override
  void info(L10nMessage message) => _show(SnackType.info, message);

  @override
  void success(L10nMessage message) => _show(SnackType.success, message);

  @override
  void error(Failure failure) => _show(SnackType.error, failure.message);

  void _show(SnackType type, L10nMessage message) {
    final overlay = _keyProvider.navigatorKey.currentState?.overlay;
    if (overlay == null || !overlay.mounted) return;

    final l10n = AppLocalizations.of(overlay.context);
    showAppSnack(overlay, message: message(l10n), type: type);
  }
}
