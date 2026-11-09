import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/di.dart';
import '../features/auth/presentation/cubit/authentication_cubit.dart';
import '../features/home/presentation/pages/home/cubit/home_cubit.dart';
import '../features/home/presentation/pages/home/home_page.dart';
import '../features/rewards/presentation/pages/rewards/cubit/rewards_cubit.dart';
import '../features/rewards/presentation/pages/rewards/rewards_page.dart';
import '../features/settings/presentation/pages/placeholder/placeholder_page.dart';
import '../features/settings/presentation/pages/settings/settings_page.dart';
import '../gen/assets.gen.dart';
import '../l10n/l10n.dart';
import '../shared/components/components.dart';
import '../shared/resources/r.dart';
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
      // The page shows beside the bar's rounded top corners.
      extendBody: true,
      body: IndexedStack(
        index: tab.index,
        children: [
          for (final tab in IndexTab.values) _body(context, tab),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: tab.index,
        onSelected: (index) => context.selectIndexTab(IndexTab.values[index]),
        items: [
          for (final tab in IndexTab.values)
            AppNavItem(icon: tab.navIcon, label: tab.label(l10n)),
        ],
      ),
    );
  }

  // Orders and Wallet stay placeholders, as the brief allows.
  Widget _body(BuildContext context, IndexTab tab) => switch (tab) {
    IndexTab.home => BlocProvider(
      create: (_) => inject<HomeCubit>()..start(),
      child: const HomePage(),
    ),
    IndexTab.rewards => BlocProvider(
      create: (_) => inject<RewardsCubit>()..start(),
      child: const RewardsPage(),
    ),
    IndexTab.settings => SettingsPage(
      onLogOut: () => unawaited(context.read<AuthenticationCubit>().logOut()),
    ),
    _ => PlaceholderPage(title: tab.label(context.l10n), icon: tab.icon),
  };
}

extension IndexTabView on IndexTab {
  String label(AppLocalizations l10n) => switch (this) {
    IndexTab.home => l10n.navHome,
    IndexTab.rewards => l10n.navRewards,
    IndexTab.orders => l10n.navOrders,
    IndexTab.wallet => l10n.navWallet,
    IndexTab.settings => l10n.navSettings,
  };

  SvgGenImage get navIcon => switch (this) {
    IndexTab.home => R.icons.navHome,
    IndexTab.rewards => R.icons.navReward,
    IndexTab.orders => R.icons.navOrders,
    IndexTab.wallet => R.icons.navWallet,
    IndexTab.settings => R.icons.navSettings,
  };

  /// For the placeholder page bodies.
  IconData get icon => switch (this) {
    IndexTab.home => CupertinoIcons.house,
    IndexTab.rewards => CupertinoIcons.rosette,
    IndexTab.orders => CupertinoIcons.arrow_2_circlepath,
    IndexTab.wallet => CupertinoIcons.creditcard,
    IndexTab.settings => CupertinoIcons.gear,
  };
}
