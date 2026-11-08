import 'package:injectable/injectable.dart';

import '../../../../config/auth_config.dart';

/// Stands in for network time in the fake backend; tests replace it.
@lazySingleton
class FakeLatency {
  const FakeLatency();

  Future<void> call() => Future<void>.delayed(AuthConfig.fakeLatency);
}
