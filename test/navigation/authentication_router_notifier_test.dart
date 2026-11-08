import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/navigation/authentication_router_notifier.dart';

void main() {
  group('AuthenticationRouterNotifier', () {
    test('notifies listeners on every auth change', () async {
      final changes = StreamController<int>();
      final notifier = AuthenticationRouterNotifier(changes.stream);
      var notifications = 0;
      notifier.addListener(() => notifications++);

      changes
        ..add(1)
        ..add(2);
      await pumpEventQueue();

      expect(notifications, 2);
      notifier.dispose();
      await changes.close();
    });

    test('stops listening to auth changes when disposed', () async {
      final changes = StreamController<int>();
      final notifier = AuthenticationRouterNotifier(changes.stream);
      expect(changes.hasListener, isTrue);

      notifier.dispose();
      await pumpEventQueue();

      expect(changes.hasListener, isFalse);
      await changes.close();
    });
  });
}
