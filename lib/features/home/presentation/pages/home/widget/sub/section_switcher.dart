import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../cubit/section_data.dart';

// Cross-fades one Home section between its skeleton, content, empty and
// error states.
class SectionSwitcher<T> extends StatelessWidget {
  const SectionSwitcher({
    super.key,
    required this.data,
    required this.skeleton,
    required this.builder,
    required this.isEmpty,
    required this.onRetry,
    this.emptyMessage,
  });

  final SectionData<T> data;
  final Widget skeleton;
  final Widget Function(T data) builder;
  final bool Function(T data) isEmpty;
  final VoidCallback onRetry;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: context.motion(AppMotion.fieldState),
      child: KeyedSubtree(
        key: ValueKey(data.runtimeType),
        child: switch (data) {
          SectionLoading() => skeleton,
          SectionFailed() => SectionMessage.error(onRetry: onRetry),
          SectionReady(:final data) when isEmpty(data) => SectionMessage.empty(
            message: emptyMessage,
          ),
          SectionReady(:final data) => builder(data),
        },
      ),
    );
  }
}

/// Small inline notice used for a section's empty and error states.
class SectionMessage extends StatelessWidget {
  const SectionMessage.empty({super.key, this.message})
    : onRetry = null,
      isError = false;

  const SectionMessage.error({super.key, required this.onRetry})
    : message = null,
      isError = true;

  final String? message;
  final VoidCallback? onRetry;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.appColors;
    final retry = onRetry;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: $styles.grid.pageMargin,
        vertical: $styles.insets.sm,
      ),
      child: Row(
        children: [
          Icon(
            isError
                ? CupertinoIcons.exclamationmark_circle
                : CupertinoIcons.tray,
            color: colors.textSecondary,
            size: $styles.size.icon,
          ),
          $styles.insets.sm.toWidthSizedBox,
          Expanded(
            child: Text(
              message ??
                  (isError ? l10n.homeSectionError : l10n.homeSectionEmpty),
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          if (retry != null)
            TextButton(onPressed: retry, child: Text(l10n.commonRetry)),
        ],
      ),
    );
  }
}
