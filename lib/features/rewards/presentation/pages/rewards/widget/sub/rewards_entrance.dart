import 'package:flutter/widgets.dart';

import '../../../../../../../shared/styles/styles.dart';

// Drives a Rewards entrance (ring, count-up, badge, ladder; cards). It
// plays each time the tab becomes visible with its data ready; the tab
// shell keeps hidden tabs built, so it follows Visibility, not mount.
// Under Reduce Motion everything shows in its final state.
class RewardsEntrance extends StatefulWidget {
  const RewardsEntrance({
    super.key,
    required this.isReady,
    required this.builder,
    this.duration = AppMotion.rewardsEntrance,
  });

  final bool isReady;
  final Duration duration;
  final Widget Function(BuildContext context, Animation<double> animation)
  builder;

  @override
  State<RewardsEntrance> createState() => _RewardsEntranceState();
}

class _RewardsEntranceState extends State<RewardsEntrance>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  var _isVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isVisible = Visibility.of(context);
    if (isVisible == _isVisible) return;
    _isVisible = isVisible;
    if (isVisible) _play();
  }

  @override
  void didUpdateWidget(RewardsEntrance oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isReady && !oldWidget.isReady) _play();
  }

  void _play() {
    if (!widget.isReady || !_isVisible) return;
    if (context.reduceMotion) {
      _controller.value = 1;
    } else {
      _controller.forward(from: 0);
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
