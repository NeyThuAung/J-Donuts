import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../styles/styles.dart';

// Primary pill button: scales down while pressed and morphs into a round
// spinner while loading. Taps are ignored while loading, so a double tap
// sends one request.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;

  /// Null shows the disabled state.
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  var _isPressed = false;

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  void _setPressed(bool isPressed) {
    if (_isPressed != isPressed) setState(() => _isPressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: _isEnabled,
      child: GestureDetector(
        onTapDown: _isEnabled ? (_) => _setPressed(true) : null,
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: _isEnabled ? widget.onPressed : null,
        child: AnimatedScale(
          scale: _isPressed ? AppMotion.pressedScale : 1,
          duration: context.motion(AppMotion.press),
          curve: AppMotion.standard,
          child: _MorphingPill(
            isLoading: widget.isLoading,
            isDisabled: widget.onPressed == null,
            label: widget.label,
          ),
        ),
      ),
    );
  }
}

class _MorphingPill extends StatelessWidget {
  const _MorphingPill({
    required this.isLoading,
    required this.isDisabled,
    required this.label,
  });

  final bool isLoading;
  final bool isDisabled;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final height = $styles.size.buttonHeight;
    return TweenAnimationBuilder<double>(
      tween: Tween(end: isLoading ? 1 : 0),
      duration: context.motion(AppMotion.buttonMorph),
      curve: AppMotion.emphasized,
      builder: (context, morph, child) => CustomSingleChildLayout(
        delegate: _PillLayout(morph: morph, height: height),
        child: child,
      ),
      child: AnimatedContainer(
        duration: context.motion(AppMotion.buttonMorph),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: isDisabled && !isLoading ? colors.disabled : colors.primary,
        ),
        child: AnimatedSwitcher(
          duration: context.motion(AppMotion.fieldState),
          child: isLoading ? const _Spinner() : _Label(label),
        ),
      ),
    );
  }
}

// Full width at morph 0, a circle of [height] at morph 1, kept centred.
// A layout delegate (not LayoutBuilder) so scroll views can measure it.
class _PillLayout extends SingleChildLayoutDelegate {
  const _PillLayout({required this.morph, required this.height});

  final double morph;
  final double height;

  @override
  Size getSize(BoxConstraints constraints) => constraints.constrain(
    Size(
      constraints.hasBoundedWidth ? constraints.maxWidth : height,
      height,
    ),
  );

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final fullWidth = getSize(constraints).width;
    final width = fullWidth + (height - fullWidth) * morph;
    return BoxConstraints.tight(Size(width, height));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      Offset((size.width - childSize.width) / 2, 0);

  @override
  bool shouldRelayout(_PillLayout oldDelegate) =>
      oldDelegate.morph != morph || oldDelegate.height != height;
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
      child: Text(
        text.toUpperCase(),
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.clip,
        style: context.textTheme.labelLarge?.copyWith(
          color: context.appColors.onPrimary,
        ),
      ),
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: $styles.size.spinner,
      child: CircularProgressIndicator(
        strokeWidth: $styles.size.spinnerStroke,
        color: context.appColors.onPrimary,
      ),
    );
  }
}
