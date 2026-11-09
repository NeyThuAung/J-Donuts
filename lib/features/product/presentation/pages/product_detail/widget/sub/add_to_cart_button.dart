import 'package:flutter/cupertino.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';

// "ADD TO CART | 3,200 MMK" with the live total (it rolls on change); after a tap it shows a
// check and "Added" for a moment (the cart is visual feedback only).
class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.totalMmk,
    required this.justAdded,
    required this.onPressed,
  });

  final int totalMmk;
  final bool justAdded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return PressableScale(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: context.motion(AppMotion.fieldState),
        height: $styles.size.buttonHeight,
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
        decoration: ShapeDecoration(
          color: justAdded ? colors.success : colors.primary,
          shape: const StadiumBorder(),
        ),
        // Long labels (Burmese at text scale 1.3) shrink instead of cutting.
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: AnimatedSwitcher(
            duration: context.motion(AppMotion.fieldState),
            child: justAdded
                ? const _AddedLabel(key: ValueKey(true))
                : _TotalLabel(key: const ValueKey(false), totalMmk: totalMmk),
          ),
        ),
      ),
    );
  }
}

class _TotalLabel extends StatelessWidget {
  const _TotalLabel({super.key, required this.totalMmk});

  static const _dividerHeight = 24.0;
  static const _dividerWidth = 1.0;

  final int totalMmk;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.appColors;
    final style = context.textTheme.labelLarge?.copyWith(
      color: colors.onPrimary,
    );
    final gap = $styles.insets.md;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.productAddToCart.toUpperCase(), maxLines: 1, style: style),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: gap),
          child: SizedBox(
            width: _dividerWidth,
            height: _dividerHeight,
            child: ColoredBox(color: colors.onPrimary),
          ),
        ),
        // Rolls to the new total when the quantity changes; fixed-width
        // digits keep the label from wobbling while it counts.
        TweenAnimationBuilder<int>(
          tween: IntTween(end: totalMmk),
          duration: context.motion(AppMotion.quantity),
          curve: AppMotion.standard,
          builder: (context, value, _) => Text(
            l10n.productPrice(value.grouped(context)).toUpperCase(),
            maxLines: 1,
            style: style?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

class _AddedLabel extends StatelessWidget {
  const _AddedLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(CupertinoIcons.checkmark_alt, color: colors.onPrimary),
        $styles.insets.xs.toWidthSizedBox,
        Text(
          context.l10n.productAdded.toUpperCase(),
          maxLines: 1,
          style: context.textTheme.labelLarge?.copyWith(
            color: colors.onPrimary,
          ),
        ),
      ],
    );
  }
}
