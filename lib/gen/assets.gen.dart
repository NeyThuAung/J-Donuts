// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/OFL-Figtree.txt
  String get oFLFigtree => 'assets/fonts/OFL-Figtree.txt';

  /// File path: assets/fonts/OFL-NotoSansMyanmar.txt
  String get oFLNotoSansMyanmar => 'assets/fonts/OFL-NotoSansMyanmar.txt';

  /// List of all assets
  List<String> get values => [oFLFigtree, oFLNotoSansMyanmar];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/apple.png
  AssetGenImage get apple => const AssetGenImage('assets/icons/apple.png');

  /// File path: assets/icons/facebook.png
  AssetGenImage get facebook =>
      const AssetGenImage('assets/icons/facebook.png');

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// List of all assets
  List<AssetGenImage> get values => [apple, facebook, google];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/donut_chocolate_hearts.png
  AssetGenImage get donutChocolateHearts =>
      const AssetGenImage('assets/images/donut_chocolate_hearts.png');

  /// File path: assets/images/donut_chocolate_sprinkles.png
  AssetGenImage get donutChocolateSprinkles =>
      const AssetGenImage('assets/images/donut_chocolate_sprinkles.png');

  /// File path: assets/images/donut_chocolate_strawberry.png
  AssetGenImage get donutChocolateStrawberry =>
      const AssetGenImage('assets/images/donut_chocolate_strawberry.png');

  /// File path: assets/images/donut_green_sprinkles.png
  AssetGenImage get donutGreenSprinkles =>
      const AssetGenImage('assets/images/donut_green_sprinkles.png');

  /// File path: assets/images/donut_pink_sprinkles.png
  AssetGenImage get donutPinkSprinkles =>
      const AssetGenImage('assets/images/donut_pink_sprinkles.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    donutChocolateHearts,
    donutChocolateSprinkles,
    donutChocolateStrawberry,
    donutGreenSprinkles,
    donutPinkSprinkles,
  ];
}

abstract final class Assets {
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
