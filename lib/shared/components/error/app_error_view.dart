import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

// Full-area error state; with a custom icon, title and message it also serves
// as a screen's empty state.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    this.onRetry,
    this.title,
    this.message,
    this.icon = CupertinoIcons.exclamationmark_circle,
  });

  static const _titleMaxLines = 2;
  static const _messageMaxLines = 3;

  final VoidCallback? onRetry;
  final String? title;
  final String? message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all($styles.grid.pageMargin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ErrorBadge(icon: icon),
            $styles.insets.sm.toHeightSizedBox,
            Text(
              title ?? l10n.errorTitle,
              maxLines: _titleMaxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium,
            ),
            $styles.insets.xxs.toHeightSizedBox,
            Text(
              message ?? l10n.errorUnknown,
              maxLines: _messageMaxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
            if (onRetry case final retry?) ...[
              $styles.insets.md.toHeightSizedBox,
              _RetryButton(onPressed: retry),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorBadge extends StatelessWidget {
  const _ErrorBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final size = $styles.size.errorBadge;
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.primaryTint,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: $styles.size.iconLg, color: colors.primary),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(CupertinoIcons.arrow_clockwise, size: $styles.size.iconSm),
      label: Text(context.l10n.commonRetry),
      style: TextButton.styleFrom(
        foregroundColor: colors.primary,
        backgroundColor: colors.primaryTint,
        minimumSize: Size.square($styles.size.minTapTarget),
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
        textStyle: context.textTheme.titleSmall,
        shape: const StadiumBorder(),
      ),
    );
  }
}
