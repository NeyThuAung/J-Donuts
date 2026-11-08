import 'package:flutter/material.dart';

import '../../../../../../shared/extensions/extensions.dart';
import '../../../../../../shared/styles/styles.dart';

// One digit box: cyan border on the next box to fill, pink on a wrong code.
class OtpBox extends StatelessWidget {
  const OtpBox({
    super.key,
    required this.digit,
    required this.isActive,
    required this.hasError,
  });

  final String? digit;
  final bool isActive;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final borderColor = hasError
        ? colors.accent
        : isActive
        ? colors.primary
        : colors.surface;
    return AnimatedContainer(
      duration: context.motion(AppMotion.fieldState),
      curve: AppMotion.standard,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular($styles.corner.xs),
        border: Border.all(color: borderColor, width: $styles.size.focusBorder),
        boxShadow: isActive ? $styles.shadow.soft : null,
      ),
      child: AnimatedSwitcher(
        duration: context.motion(AppMotion.fieldState),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: Text(
          digit ?? '',
          key: ValueKey(digit),
          style: context.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
