import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

// Small orange pill with a white outline: discounts, "New", banner tags.
class PillBadge extends StatelessWidget {
  const PillBadge({super.key, required this.label});

  static const _outlineWidth = 1.5;

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final insets = $styles.insets;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.highlight,
        shape: StadiumBorder(
          side: BorderSide(color: colors.onPrimary, width: _outlineWidth),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: insets.sm,
          vertical: insets.xxs,
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelMedium?.copyWith(
            color: colors.onPrimary,
          ),
        ),
      ),
    );
  }
}
