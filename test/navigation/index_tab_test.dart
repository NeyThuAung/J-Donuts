import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/navigation/index_tab.dart';

void main() {
  group('IndexTab.fromQuery', () {
    test('maps each tab name to its tab', () {
      for (final tab in IndexTab.values) {
        expect(IndexTab.fromQuery(tab.name), tab);
      }
    });

    test('opens Home when the parameter is missing', () {
      expect(IndexTab.fromQuery(null), IndexTab.home);
    });

    test('opens Home for an unknown tab name', () {
      expect(IndexTab.fromQuery('cart'), IndexTab.home);
    });
  });
}
