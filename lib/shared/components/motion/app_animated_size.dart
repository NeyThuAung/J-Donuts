import 'package:flutter/widgets.dart';

import '../../styles/styles.dart';

/// [AnimatedSize] that resizes at once under Reduce Motion. A zero-duration
/// AnimatedSize re-dirties its own layout and fails an assertion.
class AppAnimatedSize extends StatelessWidget {
  const AppAnimatedSize({
    super.key,
    required this.duration,
    required this.child,
    this.curve = AppMotion.standard,
    this.alignment = AlignmentDirectional.topStart,
  });

  final Duration duration;
  final Curve curve;
  final AlignmentGeometry alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    return AnimatedSize(
      duration: duration,
      curve: curve,
      alignment: alignment,
      child: child,
    );
  }
}
