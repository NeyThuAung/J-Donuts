import 'dart:math' as math;

import 'package:flutter/widgets.dart';

abstract final class AppMotion {
  // Durations
  static const press = Duration(milliseconds: 120);
  static const fieldState = Duration(milliseconds: 200);
  static const quantity = Duration(milliseconds: 250);
  static const navPill = Duration(milliseconds: 550);
  static const tabSwitch = Duration(milliseconds: 350);
  static const buttonMorph = Duration(milliseconds: 300);
  static const pageStep = Duration(milliseconds: 400);
  static const dialog = Duration(milliseconds: 200);
  static const shake = Duration(milliseconds: 450);
  static const progressRing = Duration(milliseconds: 600);
  static const ringToCheck = Duration(milliseconds: 400);
  static const donutDrift = Duration(milliseconds: 1200);
  static const homeEntrance = Duration(milliseconds: 900);
  static const productEntrance = Duration(milliseconds: 900);
  static const welcomeEntrance = Duration(milliseconds: 1400);
  static const rewardsEntrance = Duration(milliseconds: 1600);
  static const rewardsCards = Duration(milliseconds: 1400);
  static const shimmer = Duration(milliseconds: 1400);
  static const imageFade = Duration(milliseconds: 300);
  static const offlineBanner = Duration(milliseconds: 300);
  static const addedFeedback = Duration(milliseconds: 1600);
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
  // Slow start, then overshoots about 13% before settling.
  static const navPillBounce = Cubic(0.4, 0, 0.2, 1.6);

  // Slices of the Rewards entrance (one controller, rewardsEntrance long).
  // The ring sweeps while the total counts up; the badge pops in during it.
  static const rewardsRing = Interval(0, 0.875, curve: sweep);
  static const rewardsBadge = Interval(0.3, 0.6, curve: pop);
  // Each tier enters this much after the one above it, over rewardsTierSpan;
  // then the line to the next tier fills.
  static const rewardsTierStagger = 0.12;
  static const rewardsTierSpan = 0.3;
  static const rewardsLadderLine = Interval(0.45, 0.85, curve: sweep);
  // Challenge card [index] draws its progress art from this point of the
  // card entrance, one step after the card above, over rewardsArtSpan.
  static const rewardsArtStart = 0.2;
  static const rewardsArtStep = 0.1;
  static const rewardsArtSpan = 0.5;

  // Values
  static const pressedScale = 0.96;
  static const pulseScale = 1.06;
  static const dialogEnterScale = 1.08;
  static const navPillFadeIn = 0.3;
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

// Interval for tier [index] (top first) of the Rewards ladder entrance.
Interval rewardsTierInterval(int index) {
  final start = index * AppMotion.rewardsTierStagger;
  return Interval(
    start,
    math.min(start + AppMotion.rewardsTierSpan, 1),
    curve: AppMotion.pop,
  );
}

// Interval in which challenge card [index] draws its progress art.
Interval rewardsArtInterval(int index) {
  final start = math.min(
    AppMotion.rewardsArtStart + index * AppMotion.rewardsArtStep,
    1 - AppMotion.rewardsArtSpan,
  );
  return Interval(
    start,
    start + AppMotion.rewardsArtSpan,
    curve: AppMotion.sweep,
  );
}
