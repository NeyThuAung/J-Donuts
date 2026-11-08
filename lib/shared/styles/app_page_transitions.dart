import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_motion.dart';

// Android: shared-axis slide between steps. iOS: the native slide, which
// keeps the swipe-back gesture. Reduce Motion: pages just appear.
abstract final class AppPageTransitions {
  static const theme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: _ReduceMotionAware(
        SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.horizontal,
        ),
      ),
      TargetPlatform.iOS: _ReduceMotionAware(
        CupertinoPageTransitionsBuilder(),
      ),
    },
  );
}

class _ReduceMotionAware extends PageTransitionsBuilder {
  const _ReduceMotionAware(this._builder);

  final PageTransitionsBuilder _builder;

  @override
  Duration get transitionDuration => AppMotion.pageStep;

  @override
  Duration get reverseTransitionDuration => AppMotion.pageStep;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (context.reduceMotion) return child;
    return _builder.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
