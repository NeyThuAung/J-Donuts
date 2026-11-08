import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

// Inset grouped list: optional section title above a white card whose rows
// are split by hairlines.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.children, this.title});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final title = this.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(
              left: $styles.insets.md,
              bottom: $styles.insets.xs,
            ),
            child: Text(
              title,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
        Material(
          color: colors.surface,
          borderRadius: BorderRadius.circular($styles.corner.md),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (index, child) in children.indexed) ...[
                if (index > 0)
                  Divider(height: $styles.size.hairline, color: colors.track),
                child,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
