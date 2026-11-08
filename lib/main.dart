import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'di/di.dart';
import 'features/auth/presentation/cubit/authentication_cubit.dart';
import 'navigation/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await configureDependencies();

  // Known before the first frame, so the router never shows the wrong screen.
  final authCubit = inject<AuthenticationCubit>();
  await authCubit.checkSession();

  runApp(App(authCubit: authCubit, router: inject<NavigationRouter>().router));
}
