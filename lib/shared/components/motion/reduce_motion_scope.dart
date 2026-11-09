import 'package:flutter/widgets.dart';

// iOS reports Reduce Motion as accessibilityFeatures.reduceMotion, not
// disableAnimations (Android's Remove animations). Folds both into
// MediaQuery.disableAnimations so context.reduceMotion covers each platform.
class ReduceMotionScope extends StatefulWidget {
  const ReduceMotionScope({super.key, required this.child});

  final Widget child;

  @override
  State<ReduceMotionScope> createState() => _ReduceMotionScopeState();
}

class _ReduceMotionScopeState extends State<ReduceMotionScope>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAccessibilityFeatures() => setState(() {});

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final features = View.of(context).platformDispatcher.accessibilityFeatures;
    return MediaQuery(
      data: media.copyWith(
        disableAnimations: media.disableAnimations || features.reduceMotion,
      ),
      child: widget.child,
    );
  }
}
