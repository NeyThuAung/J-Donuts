import 'package:flutter/material.dart';

import '../../../../../../../l10n/l10n.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/extensions/extensions.dart';
import '../../../../../../../shared/styles/styles.dart';

// Cyan with press feedback and a gentle pulse once the challenge is
// complete; grey otherwise. No action (brief).
class EarnButton extends StatelessWidget {
  const EarnButton({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final label = context.l10n.rewardsEarn;
    final pill = Container(
      constraints: BoxConstraints(minHeight: $styles.size.minTapTarget),
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
      decoration: ShapeDecoration(
        color: isActive ? colors.primary : colors.disabled,
        shape: const StadiumBorder(),
      ),
      // Hugs the label's width, centred in the tap-target height.
      child: Align(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          label.toUpperCase(),
          style: context.textTheme.labelLarge?.copyWith(
            color: colors.onPrimary,
          ),
        ),
      ),
    );
    return Semantics(
      button: true,
      enabled: isActive,
      label: label,
      excludeSemantics: true,
      child: isActive
          ? PressableScale(
              onTap: () {},
              child: _AttentionPulse(child: pill),
            )
          : pill,
    );
  }
}

/// Breathes [child] slightly larger and back, while the screen is visible.
/// Off under Reduce Motion.
class _AttentionPulse extends StatefulWidget {
  const _AttentionPulse({required this.child});

  final Widget child;

  @override
  State<_AttentionPulse> createState() => _AttentionPulseState();
}

class _AttentionPulseState extends State<_AttentionPulse>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: AppMotion.attentionPulse,
  );
  late final _scale = _controller.drive(
    Tween(begin: 1.0, end: AppMotion.pulseScale).chain(
      CurveTween(curve: AppMotion.sweep),
    ),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The tab shell keeps hidden tabs built; pulse only while shown.
    if (Visibility.of(context) && !context.reduceMotion) {
      if (!_controller.isAnimating) _controller.repeat(reverse: true);
    } else {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ScaleTransition(scale: _scale, child: widget.child);
}
