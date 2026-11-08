import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/settings/presentation/pages/placeholder/placeholder_page.dart';
import '../l10n/l10n.dart';
import 'index_tab.dart';
import 'router_extension.dart';

// Tab shell at '/'; the selected tab comes from the ?tab= query parameter.
class IndexPage extends StatelessWidget {
  const IndexPage({super.key, required this.tab});

  static const routePath = '/';

  final IndexTab tab;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: IndexedStack(
        index: tab.index,
        children: [
          for (final tab in IndexTab.values)
            PlaceholderPage(title: tab.label(l10n), icon: tab.icon),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (index) =>
            context.selectIndexTab(IndexTab.values[index]),
        destinations: [
          for (final tab in IndexTab.values)
            NavigationDestination(icon: Icon(tab.icon), label: tab.label(l10n)),
        ],
      ),
    );
  }
}

extension IndexTabView on IndexTab {
  String label(AppLocalizations l10n) => switch (this) {
    IndexTab.home => l10n.navHome,
    IndexTab.rewards => l10n.navRewards,
    IndexTab.orders => l10n.navOrders,
    IndexTab.wallet => l10n.navWallet,
    IndexTab.settings => l10n.navSettings,
  };

  IconData get icon => switch (this) {
    IndexTab.home => CupertinoIcons.house,
    IndexTab.rewards => CupertinoIcons.rosette,
    IndexTab.orders => CupertinoIcons.arrow_2_circlepath,
    IndexTab.wallet => CupertinoIcons.creditcard,
    IndexTab.settings => CupertinoIcons.gear,
  };
}
