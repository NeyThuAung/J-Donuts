import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/core/database/database.dart';
import 'package:j_donuts/di/di.dart';

void main() {
  setUpAll(configureDependencies);

  test('resolves the third-party modules', () {
    expect(inject<AppLogger>(), isA<AppLogger>());
    expect(inject<FlutterSecureStorage>(), isA<FlutterSecureStorage>());
    expect(inject<NetworkInfo>(), isA<NetworkInfoImpl>());
  });

  // Resolving would open the on-device file; DAO tests use an in-memory one.
  test('registers the app database without opening it', () {
    expect(GetIt.instance.isRegistered<AppDatabase>(), isTrue);
  });
}
