import 'dart:async';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../config/database_config.dart';
import '../../core/database/database.dart';

@module
abstract class DatabaseModule {
  @LazySingleton(dispose: closeDatabase)
  AppDatabase get database =>
      AppDatabase(driftDatabase(name: DatabaseConfig.fileName));

  @lazySingleton
  UsersDao usersDao(AppDatabase database) => database.usersDao;
}

FutureOr<void> closeDatabase(AppDatabase database) => database.close();
