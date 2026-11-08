import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/di/di.dart';

void main() {
  setUpAll(configureDependencies);

  test('resolves the third-party modules', () {
    expect(inject<AppLogger>(), isA<AppLogger>());
    expect(inject<FlutterSecureStorage>(), isA<FlutterSecureStorage>());
    expect(inject<NetworkInfo>(), isA<NetworkInfoImpl>());
  });
}
