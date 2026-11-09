import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../core/image/image_ref_resolver.dart';
import '../../core/sync/seed_asset_reader.dart';
import '../../gen/assets.gen.dart';

@module
abstract class AssetModule {
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  @lazySingleton
  SeedAssetReader seedAssetReader(AssetBundle bundle) =>
      SeedAssetReader(bundle);

  @lazySingleton
  ImageRefResolver get imageRefResolver => ImageRefResolver(
    bundledPaths: {for (final image in Assets.images.values) image.path},
    bundledDirectory: _imagesDirectory,
  );
}

const _imagesDirectory = 'assets/images';
