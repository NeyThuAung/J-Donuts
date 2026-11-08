import 'package:flutter/widgets.dart';

import '../../styles/styles.dart';

// One controller for a whole screen entrance; each EntranceItem takes its
// own slice by index. Under Reduce Motion everything starts in place.
class StaggeredEntrance extends StatefulWidget {
  const StaggeredEntrance({
    super.key,
    required this.duration,
    required this.builder,
  });

  final Duration duration;
  final Widget Function(BuildContext context, Animation<double> animation)
  builder;

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  var _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (context.reduceMotion) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller);
}

/// Fades and slides [child] in during its slice of [animation].
class EntranceItem extends StatelessWidget {
  const EntranceItem({
    super.key,
    required this.animation,
    required this.index,
    required this.child,
    this.slideFrom = AppMotion.enterSlideOffset,
  });

  final Animation<double> animation;
  final int index;

  /// Start offset as a fraction of the child's size.
  final Offset slideFrom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final progress = animation.drive(CurveTween(curve: staggerInterval(index)));
    return FadeTransition(
      opacity: progress,
      child: SlideTransition(
        position: progress.drive(Tween(begin: slideFrom, end: Offset.zero)),
        child: child,
      ),
    );
  }
}
