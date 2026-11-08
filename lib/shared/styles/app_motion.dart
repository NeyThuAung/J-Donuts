import 'dart:math' as math;

import 'package:flutter/widgets.dart';

abstract final class AppMotion {
  // Durations
  static const press = Duration(milliseconds: 120);
  static const fieldState = Duration(milliseconds: 200);
  static const quantity = Duration(milliseconds: 250);
  static const navPill = Duration(milliseconds: 350);
  static const tabSwitch = Duration(milliseconds: 350);
  static const buttonMorph = Duration(milliseconds: 300);
  static const pageStep = Duration(milliseconds: 400);
  static const hero = Duration(milliseconds: 400);
  static const shake = Duration(milliseconds: 450);
  static const badgePop = Duration(milliseconds: 450);
  static const progressRing = Duration(milliseconds: 600);
  static const entrance = Duration(milliseconds: 500);
  static const staggerStep = Duration(milliseconds: 80);
  static const donutDrift = Duration(milliseconds: 1200);
  static const pointsRing = Duration(milliseconds: 1400);
  static const challengeArt = Duration(milliseconds: 900);
  static const shimmer = Duration(milliseconds: 1400);
  static const carouselSlide = Duration(milliseconds: 500);
  static const carouselInterval = Duration(seconds: 4);
  static const attentionPulse = Duration(milliseconds: 1200);
  static const snackIn = Duration(milliseconds: 400);
  static const snackOut = Duration(milliseconds: 250);
  static const snackDisplay = Duration(seconds: 4);

  // Curves
  static const standard = Curves.easeOutCubic;
  static const emphasized = Curves.easeInOutCubicEmphasized;
  static const enter = Curves.easeOutQuart;
  static const pop = Curves.easeOutBack;
  static const sweep = Curves.easeInOutCubic;

  // Values
  static const pressedScale = 0.96;
  static const pulseScale = 1.06;
  static const enterSlideOffset = Offset(0, 0.15);
  static const shakeDistance = 10.0;
  static const shakeOscillations = 3;
  static const maxStaggeredItems = 8;
}

// Horizontal OTP shake offset for controller progress 0..1; rests at both ends.
double shakeOffset(double progress) =>
    math.sin(AppMotion.shakeOscillations * 2 * math.pi * progress) *
    (1 - progress) *
    AppMotion.shakeDistance;

// Interval for item [index] of a staggered entrance driven by one controller.
Interval staggerInterval(int index, {Curve curve = AppMotion.enter}) {
  const items = AppMotion.maxStaggeredItems;
  const step = 1 / (items + 1);
  final start = math.min(index, items - 1) * step;
  return Interval(start, math.min(start + 2 * step, 1), curve: curve);
}

extension MotionX on BuildContext {
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);

  // Zero when Reduce Motion is on, so the animation jumps to its end state.
  Duration motion(Duration duration) => reduceMotion ? Duration.zero : duration;
}
