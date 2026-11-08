import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

// One row of a SettingsGroup: tinted icon badge, label, chevron.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// Pink icon and label, for rows like Log out.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final tint = isDestructive ? colors.accent : colors.primary;
    final insets = $styles.insets;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: $styles.size.settingsRow),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: insets.md,
            vertical: insets.sm,
          ),
          child: Row(
            children: [
              Icon(icon, size: $styles.size.icon, color: tint),
              insets.sm.toWidthSizedBox,
              Expanded(
                child: Text(
                  label,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: isDestructive ? tint : null,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_forward,
                size: $styles.size.iconSm,
                color: colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
