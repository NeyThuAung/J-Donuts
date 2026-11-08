import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/di/di.dart';
import 'package:j_donuts/navigation/navigation_key_provider.dart';

void main() {
  group('NavigationKeyProvider', () {
    setUpAll(configureDependencies);

    test('is registered once so every service shares the same key', () {
      final first = inject<INavigationKeyProvider>();
      final second = inject<INavigationKeyProvider>();

      expect(first, isA<NavigationKeyProvider>());
      expect(identical(first, second), isTrue);
      expect(first.navigatorKey, same(second.navigatorKey));
    });

    testWidgets('reaches the root navigator once the app mounts it', (
      tester,
    ) async {
      final provider = NavigationKeyProvider();
      expect(provider.navigatorKey.currentState, isNull);

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: provider.navigatorKey,
          home: const SizedBox.shrink(),
        ),
      );

      expect(provider.navigatorKey.currentState, isA<NavigatorState>());
      expect(provider.navigatorKey.currentState?.overlay, isNotNull);
    });
  });
}
