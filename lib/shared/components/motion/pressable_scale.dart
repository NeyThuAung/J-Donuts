import 'package:flutter/widgets.dart';

import '../../styles/styles.dart';

// Tappable area that scales down slightly while pressed (brief: press
// feedback). With no [onTap] it is display only.
class PressableScale extends StatefulWidget {
  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  var _isPressed = false;

  void _setPressed(bool isPressed) {
    if (_isPressed != isPressed) setState(() => _isPressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    final onTap = widget.onTap;
    return Semantics(
      button: onTap != null,
      label: widget.semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: onTap == null ? null : (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: onTap,
        child: AnimatedScale(
          scale: _isPressed ? AppMotion.pressedScale : 1,
          duration: context.motion(AppMotion.press),
          curve: AppMotion.standard,
          child: widget.child,
        ),
      ),
    );
  }
}
