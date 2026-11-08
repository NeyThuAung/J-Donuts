import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../core/logging/app_logger.dart';

@module
abstract class LoggerModule {
  @lazySingleton
  Logger get logger => Logger(printer: PrettyPrinter());

  @lazySingleton
  AppLogger appLogger(Logger logger) => AppLogger(logger);
}
