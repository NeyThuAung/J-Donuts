import 'dart:convert';

import 'package:flutter/services.dart';

import '../network/api_envelope.dart';

// Reads a bundled seed file; it has the same envelope as the API.
class SeedAssetReader {
  const SeedAssetReader(this._bundle);

  final AssetBundle _bundle;

  Future<ApiEnvelope<T>> read<T>(
    String assetPath,
    T Function(Object? json) fromJsonT,
  ) async {
    final text = await _bundle.loadString(assetPath, cache: false);
    final json = jsonDecode(text) as Map<String, dynamic>;
    return ApiEnvelope.fromJson(json, fromJsonT);
  }
}
