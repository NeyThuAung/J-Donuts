/// Where an entity's image comes from; the UI picks the matching widget.
sealed class ImageRef {
  const ImageRef();
}

/// A seed image bundled with the app, so it shows on a first offline launch.
final class AssetImageRef extends ImageRef {
  const AssetImageRef(this.path);

  final String path;

  @override
  bool operator ==(Object other) =>
      other is AssetImageRef && other.path == path;

  @override
  int get hashCode => path.hashCode;
}

/// Downloaded once, then served from the disk cache.
final class NetworkImageRef extends ImageRef {
  const NetworkImageRef(this.url);

  final String url;

  @override
  bool operator ==(Object other) =>
      other is NetworkImageRef && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
