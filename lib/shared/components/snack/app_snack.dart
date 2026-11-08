import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

enum SnackType { info, success, error }

void showAppSnack(
  OverlayState overlay, {
  required String message,
  required SnackType type,
}) {
  final context = overlay.context;
  showTopSnackBar(
    overlay,
    AppSnack(message: message, type: type),
    animationDuration: context.motion(AppMotion.snackIn),
    reverseAnimationDuration: context.motion(AppMotion.snackOut),
    displayDuration: AppMotion.snackDisplay,
    curve: AppMotion.pop,
    reverseCurve: AppMotion.standard,
    padding: EdgeInsets.all($styles.insets.md),
  );
}

class AppSnack extends StatelessWidget {
  const AppSnack({super.key, required this.message, required this.type});

  static const _maxLines = 4;

  final String message;
  final SnackType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.inverseSurface,
          borderRadius: BorderRadius.circular($styles.corner.md),
          boxShadow: $styles.shadow.card,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: $styles.insets.md,
            vertical: $styles.insets.sm,
          ),
          child: Row(
            children: [
              Icon(_icon, size: $styles.size.icon, color: _iconColor(colors)),
              $styles.insets.sm.toWidthSizedBox,
              Expanded(
                child: Text(
                  message,
                  maxLines: _maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.onInverseSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData get _icon => switch (type) {
    SnackType.info => CupertinoIcons.info_circle_fill,
    SnackType.success => CupertinoIcons.checkmark_circle_fill,
    SnackType.error => CupertinoIcons.exclamationmark_circle_fill,
  };

  Color _iconColor(AppThemeColors colors) => switch (type) {
    SnackType.info => colors.primary,
    SnackType.success => colors.success,
    SnackType.error => colors.accent,
  };
}
