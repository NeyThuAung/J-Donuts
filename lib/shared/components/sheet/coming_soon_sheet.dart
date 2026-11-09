import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../extensions/extensions.dart';
import '../../styles/styles.dart';
import '../button/app_button.dart';

/// For actions the demo does not implement (social sign-in, legal pages).
Future<void> showComingSoonSheet(
  BuildContext context, {
  required String title,
}) => showModalBottomSheet<void>(
  context: context,
  backgroundColor: context.appColors.surface,
  showDragHandle: true,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular($styles.corner.lg),
    ),
  ),
  builder: (_) => ComingSoonSheet(title: title),
);

class ComingSoonSheet extends StatelessWidget {
  const ComingSoonSheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final insets = $styles.insets;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(insets.lg, 0, insets.lg, insets.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.hourglass,
              size: $styles.size.iconLg,
              color: context.appColors.accent,
            ),
            insets.sm.toHeightSizedBox,
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
            insets.xs.toHeightSizedBox,
            Text(
              l10n.commonNotInDemo,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
            insets.lg.toHeightSizedBox,
            AppButton(
              label: l10n.commonClose,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
