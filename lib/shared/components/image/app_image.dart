import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/image/image_ref.dart';
import '../../../l10n/l10n.dart';
import '../../styles/styles.dart';
import '../loading/app_shimmer.dart';

// Bundled seed images load from assets; others from the network through a
// disk cache, with a shimmer placeholder and an error state.
class AppImage extends StatelessWidget {
  const AppImage(
    this.image, {
    super.key,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.semanticLabel,
  });

  final ImageRef image;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final picture = LayoutBuilder(
      builder: (context, constraints) =>
          _picture(context, _decodeWidth(context, constraints)),
    );
    final radius = borderRadius;
    return Semantics(
      image: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: radius == null
          ? picture
          : ClipRRect(borderRadius: radius, child: picture),
    );
  }

  Widget _picture(BuildContext context, int? decodeWidth) => switch (image) {
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
  int? _decodeWidth(BuildContext context, BoxConstraints constraints) {
    if (!constraints.hasBoundedWidth) return null;
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return (constraints.maxWidth * pixelRatio).round();
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: SizedBox.expand(
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
      child: SizedBox.expand(
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
