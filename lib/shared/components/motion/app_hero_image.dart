import 'package:flutter/widgets.dart';

import '../../../core/image/image_ref.dart';
import '../../styles/styles.dart';
import '../image/app_image.dart';

abstract final class HeroTags {
  /// [from] scopes the tag (e.g. the Home section) so a product shown twice
  /// on one screen never shares a tag.
  static String product({required String from, required String id}) =>
      'product/$from/$id';
}

// An image that flies between screens. Both ends and the flight decode the
// image at the screen width, so the flight reuses the decoded image instead
// of reloading it as its size changes. No tag, or Reduce Motion: no flight.
class AppHeroImage extends StatelessWidget {
  const AppHeroImage({
    super.key,
    required this.tag,
    required this.image,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.semanticLabel,
  });

  final String? tag;
  final ImageRef image;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final decodeWidth = MediaQuery.sizeOf(context).width;
    final picture = AppImage(
      image,
      fit: fit,
      borderRadius: borderRadius,
      semanticLabel: semanticLabel,
      decodeWidth: decodeWidth,
    );
    final tag = this.tag;
    if (tag == null) return picture;
    return HeroMode(
      enabled: !context.reduceMotion,
      child: Hero(
        tag: tag,
        // The whole picture, rounded like the ends, so corners never jump.
        flightShuttleBuilder: (_, _, _, _, _) => AppImage(
          image,
          fit: BoxFit.contain,
          borderRadius: BorderRadius.circular($styles.corner.md),
          decodeWidth: decodeWidth,
        ),
        child: picture,
      ),
    );
  }
}
