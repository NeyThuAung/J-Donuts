import 'dart:async';

import 'package:flutter/foundation.dart';

// Makes GoRouter re-run its redirect whenever the auth state changes.
class AuthenticationRouterNotifier extends ChangeNotifier {
  AuthenticationRouterNotifier(Stream<Object?> authChanges) {
    _subscription = authChanges.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
