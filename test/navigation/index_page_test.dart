import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/features/home/presentation/pages/home/home_page.dart';
import 'package:j_donuts/features/rewards/presentation/pages/rewards/rewards_page.dart';
import 'package:j_donuts/features/settings/presentation/pages/placeholder/placeholder_page.dart';
import 'package:j_donuts/features/settings/presentation/pages/settings/settings_page.dart';
import 'package:j_donuts/l10n/l10n.dart';
import 'package:j_donuts/navigation/index_page.dart';
import 'package:j_donuts/navigation/index_tab.dart';
import 'package:j_donuts/shared/components/components.dart';
import 'package:j_donuts/shared/styles/styles.dart';

import '../helpers/test_page_cubits.dart';

GoRouter _router(String location) => GoRouter(
  initialLocation: location,
  routes: [
    GoRoute(
      path: IndexPage.routePath,
      builder: (context, state) => IndexPage(
        tab: IndexTab.fromQuery(state.uri.queryParameters[IndexTab.queryKey]),
      ),
    ),
  ],
);

Future<GoRouter> _pump(WidgetTester tester, String location) async {
  registerPageCubits();
  final router = _router(location);
  addTearDown(router.dispose);
  await tester.pumpWidget(
    MaterialApp.router(
      theme: AppTheme.light(const Locale('en')),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

// Nav buttons are the bar's tap targets, one per tab in order.
Finder _navButton(IndexTab tab) => find
    .descendant(
      of: find.byType(AppBottomNavBar),
      matching: find.byType(GestureDetector),
    )
    .at(tab.index);

int _visibleTab(WidgetTester tester) =>
    tester.widget<IndexedStack>(find.byType(IndexedStack)).index!;

void main() {
  group('IndexPage', () {
    testWidgets('opens Home when no tab is given', (tester) async {
      await _pump(tester, '/');

      expect(_visibleTab(tester), IndexTab.home.index);
      expect(
        tester
            .widget<AppBottomNavBar>(find.byType(AppBottomNavBar))
            .selectedIndex,
        IndexTab.home.index,
      );
    });

    testWidgets('opens the tab named in the query parameter', (tester) async {
      await _pump(tester, '/?tab=rewards');

      expect(_visibleTab(tester), IndexTab.rewards.index);
    });

    testWidgets(
      'shows Home, Rewards and Settings on their tabs and placeholders on the rest',
      (tester) async {
        await _pump(tester, '/');

        expect(find.byType(HomePage, skipOffstage: false), findsOneWidget);
        expect(find.byType(RewardsPage, skipOffstage: false), findsOneWidget);
        expect(find.byType(SettingsPage, skipOffstage: false), findsOneWidget);
        expect(
          find.byType(PlaceholderPage, skipOffstage: false),
          findsNWidgets(IndexTab.values.length - 3),
        );
      },
    );

    testWidgets('tapping a tab switches to it and updates the location', (
      tester,
    ) async {
      final router = await _pump(tester, '/');

      await tester.tap(_navButton(IndexTab.wallet));
      await tester.pumpAndSettle();

      expect(_visibleTab(tester), IndexTab.wallet.index);
      expect(
        router.routerDelegate.currentConfiguration.uri.toString(),
        '/?tab=wallet',
      );
    });

    testWidgets('keeps the same page widget state when switching tabs', (
      tester,
    ) async {
      await _pump(tester, '/');
      final stackBefore = tester.element(find.byType(IndexedStack));

      await tester.tap(_navButton(IndexTab.rewards));
      await tester.pumpAndSettle();

      expect(tester.element(find.byType(IndexedStack)), same(stackBefore));
    });
  });
}
