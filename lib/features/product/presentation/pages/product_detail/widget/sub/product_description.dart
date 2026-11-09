import 'package:flutter/cupertino.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';

// "What's this?" on the left, a thin line, the description on the right.
class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.description});

  // The description takes three times the label column's width.
  static const _textFlex = 3;
  static const _lineWidth = 2.0;

  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final insets = $styles.insets;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: _WhatsThis()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: insets.md),
            child: SizedBox(
              width: _lineWidth,
              child: ColoredBox(color: colors.surface),
            ),
          ),
          Expanded(
            flex: _textFlex,
            child: Text(
              description,
              style: context.textTheme.bodyLarge?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatsThis extends StatelessWidget {
  const _WhatsThis();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          CupertinoIcons.question_circle_fill,
          color: context.appColors.success,
          size: $styles.size.icon,
        ),
        $styles.insets.xs.toHeightSizedBox,
        Text(
          context.l10n.productWhatsThis,
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
