import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/home_section_type.dart';

part 'home_models.freezed.dart';
part 'home_models.g.dart';

// Shapes of the items in /v1/banners.json, sections.json and shops.json.
@freezed
abstract class BannerModel with _$BannerModel {
  const factory BannerModel({
    required String id,
    required String tag,
    required String title,
    required String imageUrl,
    required int sortOrder,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}

@freezed
abstract class SectionModel with _$SectionModel {
  const factory SectionModel({
    required String id,
    required HomeSectionType type,
    required int sortOrder,
    required List<String> productIds,
  }) = _SectionModel;

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);
}

@freezed
abstract class ShopModel with _$ShopModel {
  const factory ShopModel({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    required int sortOrder,
  }) = _ShopModel;

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);
}

List<BannerModel> bannersFromJson(Object? json) =>
    _listFromJson(json, BannerModel.fromJson);

List<SectionModel> sectionsFromJson(Object? json) =>
    _listFromJson(json, SectionModel.fromJson);

List<ShopModel> shopsFromJson(Object? json) =>
    _listFromJson(json, ShopModel.fromJson);

List<T> _listFromJson<T>(
  Object? json,
  T Function(Map<String, dynamic> json) fromJson,
) => (json! as List<Object?>)
    .map((item) => fromJson(item! as Map<String, dynamic>))
    .toList();
