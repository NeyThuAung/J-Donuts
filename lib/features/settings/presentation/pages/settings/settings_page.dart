import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/extensions/extensions.dart';
import '../../../../../shared/styles/styles.dart';

// The Settings tab. Log out is confirmed first; the session itself is ended by
// the caller (the tab shell owns the app-wide auth cubit).
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.onLogOut});

  final VoidCallback onLogOut;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all($styles.grid.pageMargin),
        children: [
          Semantics(
            header: true,
            child: Text(
              l10n.navSettings,
              style: context.textTheme.headlineMedium,
            ),
          ),
          $styles.insets.lg.toHeightSizedBox,
          SettingsGroup(
            title: l10n.settingsAccount,
            children: [
              SettingsTile(
                icon: CupertinoIcons.square_arrow_right,
                label: l10n.settingsLogOut,
                isDestructive: true,
                onTap: () => unawaited(_confirmLogOut(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogOut(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.settingsLogOutTitle,
      message: l10n.settingsLogOutMessage,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.settingsLogOut,
      isDestructive: true,
    );
    if (confirmed) onLogOut();
  }
}
