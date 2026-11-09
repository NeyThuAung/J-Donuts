import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../config/api_config.dart';
import '../../core/logging/app_logger.dart';
import '../../core/network/network_info.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @LazySingleton(as: NetworkInfo)
  NetworkInfoImpl networkInfo(Connectivity connectivity) =>
      NetworkInfoImpl(connectivity, InternetAddress.lookup);

  @lazySingleton
  Dio dio(AppLogger logger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: {HttpHeaders.acceptHeader: ContentType.json.mimeType},
      ),
    );
    // Retries connection errors, timeouts and retryable 5xx/429 statuses.
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: logger.debug,
        retries: ApiConfig.maxRetries,
        retryDelays: ApiConfig.retryDelays,
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(requestHeader: true));
    }
    return dio;
  }
}
