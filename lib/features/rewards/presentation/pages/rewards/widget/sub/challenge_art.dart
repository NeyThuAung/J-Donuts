import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/styles/styles.dart';
import '../../../../../domain/entity/challenge_artwork.dart';
import '../../../../../domain/entity/challenge_entity.dart';

// A challenge's photo drawing its own progress: the donut colours in by
// quarters over a grey copy; the coffee gets an orange gauge that fills.
// [progress] runs 0 to 1 as the progress draws in.
class ChallengeArt extends StatelessWidget {
  const ChallengeArt({
    super.key,
    required this.challenge,
    required this.size,
    required this.progress,
  });

  static const maxSize = 120.0;
  static const _minSize = 72.0;
  static const _widthShare = 0.4;

  /// About 40% of the card's content width, so the text keeps room on a
  /// small phone.
  static double sizeFor(double contentWidth) =>
      (contentWidth * _widthShare).clamp(_minSize, maxSize);

  final ChallengeEntity challenge;
  final double size;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: switch (challenge.artwork) {
        ChallengeArtwork.donutQuarters => _DonutQuarters(
          challenge: challenge,
          progress: progress,
        ),
        ChallengeArtwork.arc => _CoffeeGauge(
          challenge: challenge,
          progress: progress,
        ),
      },
    );
  }
}

class _DonutQuarters extends StatelessWidget {
  const _DonutQuarters({required this.challenge, required this.progress});

  // Luminance weights (Rec. 709) and a lift toward white, for the grey copy.
  static const _red = 0.2126;
  static const _green = 0.7152;
  static const _blue = 0.0722;
  static const _lift = 0.35;
  static const _greyLift = 255 * _lift;
  static const _keep = 1 - _lift;
  static const _greyscale = ColorFilter.matrix([
    _red * _keep, _green * _keep, _blue * _keep, 0, _greyLift, //
    _red * _keep, _green * _keep, _blue * _keep, 0, _greyLift, //
    _red * _keep, _green * _keep, _blue * _keep, 0, _greyLift, //
    0, 0, 0, 1, 0,
  ]);

  final ChallengeEntity challenge;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    final photo = AppImage(
      challenge.image,
      fit: BoxFit.contain,
      semanticLabel: challenge.title,
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        ExcludeSemantics(
          child: ColorFiltered(colorFilter: _greyscale, child: photo),
        ),
        AnimatedBuilder(
          animation: progress,
          builder: (context, child) => ClipPath(
            clipper: _SliceClipper(challenge.fraction * progress.value),
            child: child,
          ),
          child: photo,
        ),
      ],
    );
  }
}

/// A pie slice from 12 o'clock, clockwise, [share] of a full turn.
class _SliceClipper extends CustomClipper<Path> {
  const _SliceClipper(this.share);

  final double share;

  @override
  Path getClip(Size size) {
    final rect = Offset.zero & size;
    // A full-turn arc has no area, so a complete donut clips to the box.
    if (share >= 1) return Path()..addRect(rect);
    // Larger than the image so the slice covers its corners.
    final circle = Rect.fromCircle(
      center: rect.center,
      radius: size.longestSide,
    );
    return Path()
      ..moveTo(rect.center.dx, rect.center.dy)
      ..arcTo(circle, -math.pi / 2, share * 2 * math.pi, false)
      ..close();
  }

  @override
  bool shouldReclip(_SliceClipper oldClipper) => oldClipper.share != share;
}

class _CoffeeGauge extends StatelessWidget {
  const _CoffeeGauge({required this.challenge, required this.progress});

  static const _photoShare = 0.62;
  // The photo sits a little low, under the gauge's open arc.
  static const _photoAlignment = Alignment(0, 0.45);

  final ChallengeEntity challenge;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: progress,
            builder: (context, _) => CustomPaint(
              painter: _GaugePainter(
                fill: challenge.fraction * progress.value,
                track: colors.track,
                filled: colors.highlight,
              ),
            ),
          ),
          Align(
            alignment: _photoAlignment,
            child: SizedBox.square(
              dimension: constraints.maxWidth * _photoShare,
              child: ClipOval(
                child: AppImage(
                  challenge.image,
                  semanticLabel: challenge.title,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// An open gauge from about 8 o'clock over the top to 3 o'clock, as in
/// screen 10; the orange part covers [fill] (0 to 1) of it.
class _GaugePainter extends CustomPainter {
  const _GaugePainter({
    required this.fill,
    required this.track,
    required this.filled,
  });

  static const _start = math.pi * 165 / 180;
  static const _sweep = math.pi * 210 / 180;
  static const _strokeShare = 0.1;

  final double fill;
  final Color track;
  final Color filled;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * _strokeShare;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    Paint band(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, _start, _sweep, false, band(track));
    if (fill > 0) {
      canvas.drawArc(rect, _start, _sweep * fill, false, band(filled));
    }
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.track != track ||
      oldDelegate.filled != filled;
}
