import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/core.dart';
import 'di/di.dart';
import 'features/auth/presentation/cubit/authentication_cubit.dart';
import 'features/home/domain/usecase/seed_local_data_usecase.dart';
import 'navigation/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await configureDependencies();
  await _seedLocalData();

  // Known before the first frame, so the router never shows the wrong screen.
  final authCubit = inject<AuthenticationCubit>();
  await authCubit.checkSession();

  runApp(App(authCubit: authCubit, router: inject<NavigationRouter>().router));
}

// Bundled data first, so every screen works offline from the first launch.
// A failure is logged; the screens then show their empty or error states.
Future<void> _seedLocalData() async {
  final result = await inject<SeedLocalDataUseCase>()(const NoParams());
  if (result case Failed(:final failure, :final error)) {
    inject<AppLogger>().error('Seeding failed: $failure', error: error);
  }
}
