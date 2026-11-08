import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

// Narrow enough to read as a dialog on large phones.
const _maxDialogWidth = 360.0;

/// True when confirmed; false when cancelled or dismissed.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String cancelLabel,
  required String confirmLabel,
  bool isDestructive = false,
}) async {
  FocusScope.of(context).unfocus();
  final confirmed = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: context.appColors.scrim,
    transitionDuration: context.motion(AppMotion.dialog),
    pageBuilder: (_, _, _) => ConfirmDialog(
      title: title,
      message: message,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      isDestructive: isDestructive,
    ),
    // Fades in while settling from slightly larger, like an iOS alert.
    transitionBuilder: (_, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: AppMotion.standard,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(
            begin: AppMotion.dialogEnterScale,
            end: 1.0,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
  return confirmed ?? false;
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.cancelLabel,
    required this.confirmLabel,
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String cancelLabel;
  final String confirmLabel;

  /// Pink confirm text on a muted button instead of a filled primary one.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final insets = $styles.insets;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: insets.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxDialogWidth),
          child: Material(
            color: context.appColors.surface,
            borderRadius: BorderRadius.circular($styles.corner.lg),
            child: Padding(
              padding: EdgeInsets.all(insets.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    header: true,
                    child: Text(title, style: context.textTheme.titleLarge),
                  ),
                  insets.xs.toHeightSizedBox,
                  Text(
                    message,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.appColors.textSecondary,
                    ),
                  ),
                  insets.lg.toHeightSizedBox,
                  _actions(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    final colors = context.appColors;
    return Row(
      children: [
        Expanded(
          child: _DialogButton(
            label: cancelLabel,
            background: colors.surfaceMuted,
            foreground: colors.textPrimary,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),
        $styles.insets.xs.toWidthSizedBox,
        Expanded(
          child: _DialogButton(
            label: confirmLabel,
            background: isDestructive ? colors.surfaceMuted : colors.primary,
            foreground: isDestructive ? colors.accent : colors.onPrimary,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ),
      ],
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        minimumSize: Size.fromHeight($styles.size.buttonHeight),
        shape: const StadiumBorder(),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: context.textTheme.labelLarge?.copyWith(color: foreground),
      ),
    );
  }
}
