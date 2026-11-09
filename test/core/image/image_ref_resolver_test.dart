import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/image/image_ref.dart';
import 'package:j_donuts/core/image/image_ref_resolver.dart';

const _resolver = ImageRefResolver(
  bundledPaths: {'assets/images/donut_pink_sprinkles.png'},
  bundledDirectory: 'assets/images',
);

void main() {
  group('ImageRefResolver', () {
    test('loads a bundled seed image from assets, so it works offline', () {
      expect(
        _resolver.resolve(
          'https://host/J-Donuts/images/donut_pink_sprinkles.png',
        ),
        const AssetImageRef('assets/images/donut_pink_sprinkles.png'),
      );
    });

    test('downloads an image that is not bundled', () {
      const url = 'https://host/J-Donuts/images/new_donut.png';

      expect(_resolver.resolve(url), const NetworkImageRef(url));
    });

    test('treats an unparsable URL as a network image', () {
      expect(_resolver.resolve(''), const NetworkImageRef(''));
    });
  });
}
