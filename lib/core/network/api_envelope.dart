import 'package:freezed_annotation/freezed_annotation.dart';

import '../exceptions/remote_exception.dart';

part 'api_envelope.freezed.dart';
part 'api_envelope.g.dart';

// Every /v1 response: {data, error, meta}.
@Freezed(genericArgumentFactories: true)
abstract class ApiEnvelope<T> with _$ApiEnvelope<T> {
  const factory ApiEnvelope({
    T? data,
    ApiError? error,
    required ApiMeta meta,
  }) = _ApiEnvelope<T>;

  factory ApiEnvelope.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiEnvelopeFromJson(json, fromJsonT);
}

@freezed
abstract class ApiError with _$ApiError {
  const factory ApiError({required String code, required String message}) =
      _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

/// [version] grows whenever the published data changes.
@freezed
abstract class ApiMeta with _$ApiMeta {
  const factory ApiMeta({required int version}) = _ApiMeta;

  factory ApiMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaFromJson(json);
}

extension ApiEnvelopeData<T> on ApiEnvelope<T> {
  /// The payload, or a [ServerException] when the envelope carries an error.
  T requireData() {
    final error = this.error;
    if (error != null) throw ServerException(error.message, error.code);
    final data = this.data;
    if (data == null) throw const ServerException('Response has no data');
    return data;
  }
}
