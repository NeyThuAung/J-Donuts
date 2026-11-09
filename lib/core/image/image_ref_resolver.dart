import 'image_ref.dart';

// Seed images are bundled under the same file name the server uses, so a
// URL whose file is bundled loads from assets; anything else is downloaded.
class ImageRefResolver {
  const ImageRefResolver({
    required this.bundledPaths,
    required this.bundledDirectory,
  });

  final Set<String> bundledPaths;
  final String bundledDirectory;

  ImageRef resolve(String url) {
    final segments = Uri.tryParse(url)?.pathSegments ?? const <String>[];
    final assetPath = segments.isEmpty
        ? null
        : '$bundledDirectory/${segments.last}';
    return bundledPaths.contains(assetPath)
        ? AssetImageRef(assetPath!)
        : NetworkImageRef(url);
  }
}
