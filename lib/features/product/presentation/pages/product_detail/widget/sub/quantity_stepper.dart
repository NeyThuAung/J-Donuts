import 'package:flutter/cupertino.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';

// − quantity + pill; the number slides and fades when it changes.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  static const height = 72.0;
  static const _outline = 3.0;
  static const _numberWidth = 56.0;

  final int quantity;

  /// Null at the limit: the button greys out.
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.l10n;
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
      decoration: ShapeDecoration(
        color: colors.background,
        shape: StadiumBorder(
          side: BorderSide(color: colors.surface, width: _outline),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RoundButton(
            icon: CupertinoIcons.minus,
            label: l10n.productDecrease,
            onTap: onDecrement,
          ),
          SizedBox(
            width: _numberWidth,
            child: Semantics(
              liveRegion: true,
              label: l10n.productQuantity(quantity),
              child: ExcludeSemantics(child: _AnimatedNumber(value: quantity)),
            ),
          ),
          _RoundButton(
            icon: CupertinoIcons.plus,
            label: l10n.productIncrease,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class _AnimatedNumber extends StatelessWidget {
  const _AnimatedNumber({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: context.motion(AppMotion.quantity),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: Text(
        '$value',
        key: ValueKey(value),
        textAlign: TextAlign.center,
        maxLines: 1,
        style: context.textTheme.headlineMedium,
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  static const _circle = 40.0;

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return PressableScale(
      onTap: onTap,
      semanticLabel: label,
      child: SizedBox.square(
        dimension: $styles.size.minTapTarget,
        child: Center(
          child: AnimatedContainer(
            duration: context.motion(AppMotion.fieldState),
            width: _circle,
            height: _circle,
            decoration: BoxDecoration(
              color: onTap == null ? colors.disabled : colors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: colors.onPrimary, size: $styles.size.icon),
          ),
        ),
      ),
    );
  }
}
