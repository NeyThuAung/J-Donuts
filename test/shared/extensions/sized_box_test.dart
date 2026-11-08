import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/shared/extensions/sized_box.dart';

void main() {
  group('SizedBoxX', () {
    test('toWidthSizedBox creates a box with only that width', () {
      final box = 12.toWidthSizedBox;

      expect(box.width, 12);
      expect(box.height, isNull);
    });

    test('toHeightSizedBox creates a box with only that height', () {
      final box = 8.5.toHeightSizedBox;

      expect(box.height, 8.5);
      expect(box.width, isNull);
    });
  });
}
