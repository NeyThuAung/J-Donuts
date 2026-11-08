import 'dart:convert';

import 'package:logger/logger.dart';

class AppLogger {
  const AppLogger(this._logger);

  final Logger _logger;

  static const _encoder = JsonEncoder.withIndent('  ');

  void debug(String message, {Map<String, Object?>? data}) =>
      _logger.d(_format(message, data));

  void info(String message, {Map<String, Object?>? data}) =>
      _logger.i(_format(message, data));

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? data,
  }) => _logger.e(_format(message, data), error: error, stackTrace: stackTrace);

  String _format(String message, Map<String, Object?>? data) =>
      data == null ? message : '$message\n${_encoder.convert(data)}';
}
