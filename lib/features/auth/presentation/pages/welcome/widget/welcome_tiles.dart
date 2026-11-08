import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/resources/r.dart';
import '../../../../../../shared/styles/styles.dart';

// Share of the area that fades into the page colour at the bottom.
const _fadeShare = 0.25;
// Donut image width as a share of its tile.
const _imageShare = 0.78;

// One rounded colour tile with a donut. Position and size are shares of the
// tiles area; the right column runs off the screen edge as in the design.
class _Tile {
  const _Tile({
    required this.rect,
    required this.color,
    required this.image,
    required this.slideFrom,
  });

  /// left, top, width, height as shares of the area.
  final Rect rect;
  final Color color;
  final AssetGenImage image;

  /// Where it slides in from, as a share of its own size.
  final Offset slideFrom;
}

List<_Tile> _tiles(AppThemeColors colors) => [
  _Tile(
    rect: const Rect.fromLTWH(0, -0.04, 0.53, 0.42),
    color: colors.progressSecondary,
    image: R.images.donutGreenSprinkles,
    slideFrom: const Offset(0, -0.3),
  ),
  _Tile(
    rect: const Rect.fromLTWH(0.57, 0.06, 0.53, 0.42),
    color: colors.surface,
    image: R.images.donutChocolateStrawberry,
    slideFrom: const Offset(0.4, 0),
  ),
  _Tile(
    rect: const Rect.fromLTWH(0, 0.42, 0.53, 0.44),
    color: colors.homeHeader,
    image: R.images.donutPinkSprinkles,
    slideFrom: const Offset(-0.4, 0),
  ),
  _Tile(
    rect: const Rect.fromLTWH(0.57, 0.52, 0.53, 0.46),
    color: colors.highlight,
    image: R.images.donutChocolateSprinkles,
    slideFrom: const Offset(0, 0.3),
  ),
];

// The donut tiles at the top of Welcome; they fill the height they are given
// and slide in one after another (entrance slots 0–3).
class WelcomeTiles extends StatelessWidget {
  const WelcomeTiles({super.key, required this.animation});

  static const entranceSlots = 4;

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return ExcludeSemantics(
      child: LayoutBuilder(
        builder: (context, constraints) => _stack(colors, constraints.biggest),
      ),
    );
  }

  Widget _stack(AppThemeColors colors, Size size) => Stack(
    children: [
      for (final (index, tile) in _tiles(colors).indexed)
        _positioned(tile, index, size),
      Positioned.fill(
        top: size.height * (1 - _fadeShare),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.authGradientTop.withValues(alpha: 0),
                colors.authGradientTop,
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget _positioned(_Tile tile, int index, Size size) {
    final tileWidth = tile.rect.width * size.width;
    return Positioned(
      left: tile.rect.left * size.width,
      top: tile.rect.top * size.height,
      width: tileWidth,
      height: tile.rect.height * size.height,
      child: EntranceItem(
        animation: animation,
        index: index,
        slideFrom: tile.slideFrom,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: tile.color,
            borderRadius: BorderRadius.circular($styles.corner.lg),
          ),
          child: Center(
            child: tile.image.image(
              width: tileWidth * _imageShare,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
