import 'dart:io';

import 'package:dio/dio.dart';

import '../exceptions/remote_exception.dart';

extension DioExceptionMapper on DioException {
  RemoteException toRemoteException() => switch (type) {
    DioExceptionType.connectionError => InternetConnectionException(
      _reason('Connection error'),
    ),
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => RequestTimeoutException(
      _reason('Request timed out'),
    ),
    DioExceptionType.badResponse => _fromStatusCode(response?.statusCode),
    DioExceptionType.unknown when error is SocketException =>
      InternetConnectionException(_reason('Connection error')),
    _ => ServerException(_reason('Unexpected network error')),
  };

  RemoteException _fromStatusCode(int? statusCode) {
    final code = statusCode?.toString();
    return switch (statusCode) {
      HttpStatus.badRequest => BadRequestException(
        _reason('Bad request'),
        code,
      ),
      HttpStatus.unauthorized || HttpStatus.forbidden => UnauthorizedException(
        _reason('Unauthorized'),
        code,
      ),
      HttpStatus.notFound => NotFoundException(_reason('Not found'), code),
      _ => ServerException(_reason('Server error'), code),
    };
  }

  String _reason(String fallback) => message ?? fallback;
}
