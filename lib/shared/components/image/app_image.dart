import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/image/image_ref.dart';
import '../../../l10n/l10n.dart';
import '../../styles/styles.dart';
import '../loading/app_shimmer.dart';

// Bundled seed images load from assets; others from the network through a
// disk cache, with a shimmer placeholder and an error state. With contain,
// [borderRadius] rounds the image itself, not the empty bands beside it.
class AppImage extends StatelessWidget {
  const AppImage(
    this.image, {
    super.key,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.semanticLabel,
    this.decodeWidth,
  });

  final ImageRef image;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? semanticLabel;

  /// Fixed decode width (logical px) instead of the laid-out width. A Hero
  /// image uses it on both ends and in flight, so the size changes of the
  /// flight reuse one decoded image instead of reloading every frame.
  final double? decodeWidth;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius;
    final picture = radius != null && fit == BoxFit.contain
        ? _RoundedContain(radius: radius, image: _sizedPicture)
        : _boxPicture(context, radius);
    return Semantics(
      image: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: picture,
    );
  }

  Widget _boxPicture(BuildContext context, BorderRadius? radius) {
    final picture = _sizedPicture(context, fit);
    return radius == null
        ? picture
        : ClipRRect(borderRadius: radius, child: picture);
  }

  // Decoded at [decodeWidth], or at the laid-out width when it is null.
  Widget _sizedPicture(BuildContext context, BoxFit? fit) {
    final fixedWidth = decodeWidth;
    if (fixedWidth != null) {
      return _picture(context, fit, _toPixels(context, fixedWidth));
    }
    return LayoutBuilder(
      builder: (context, constraints) => _picture(
        context,
        fit,
        _toPixels(
          context,
          constraints.hasBoundedWidth ? constraints.maxWidth : null,
        ),
      ),
    );
  }

  Widget _picture(BuildContext context, BoxFit? fit, int? decodeWidth) =>
      switch (image) {
        AssetImageRef(:final path) => Image.asset(
          path,
          fit: fit,
          cacheWidth: decodeWidth,
          errorBuilder: (_, _, _) => const _ImageError(),
        ),
        NetworkImageRef(:final url) => CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          memCacheWidth: decodeWidth,
          fadeInDuration: context.motion(AppMotion.imageFade),
          placeholder: (_, _) => const _ImagePlaceholder(),
          errorWidget: (_, _, _) => const _ImageError(),
        ),
      };

  // Decode at the drawn size: less memory and smoother scrolling.
  int? _toPixels(BuildContext context, double? logicalWidth) {
    if (logicalWidth == null) return null;
    return (logicalWidth * MediaQuery.devicePixelRatioOf(context)).round();
  }
}

// Lays the image out at its own aspect ratio, scaled to fit the box, so the
// clip follows the picture. Placeholder and error still fill the box.
class _RoundedContain extends StatelessWidget {
  const _RoundedContain({required this.radius, required this.image});

  final BorderRadius radius;
  final Widget Function(BuildContext context, BoxFit? fit) image;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => Center(
      child: ClipRRect(
        borderRadius: radius,
        child: FittedBox(
          child: _BoxSize(
            size: constraints.biggest,
            child: image(context, null),
          ),
        ),
      ),
    ),
  );
}

// Inside FittedBox the child is unconstrained; this gives the expanding
// placeholder and error the box size while the image keeps its own size.
class _BoxSize extends InheritedWidget {
  const _BoxSize({required this.size, required super.child});

  final Size size;

  static Size? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_BoxSize>()?.size;

  @override
  bool updateShouldNotify(_BoxSize oldWidget) => oldWidget.size != size;
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: _FillBox(
      child: ColoredBox(color: context.appColors.shimmerBase),
    ),
  );
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Semantics(
      label: context.l10n.commonImageUnavailable,
      child: _FillBox(
        child: ColoredBox(
          color: colors.surfaceMuted,
          child: Icon(
            CupertinoIcons.photo,
            color: colors.textSecondary,
            size: $styles.size.iconLg,
          ),
        ),
      ),
    );
  }
}

// Fills the box: the given size inside a rounded contain, else expands.
class _FillBox extends StatelessWidget {
  const _FillBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = _BoxSize.of(context);
    return size == null || !size.isFinite
        ? SizedBox.expand(child: child)
        : SizedBox.fromSize(size: size, child: child);
  }
}
