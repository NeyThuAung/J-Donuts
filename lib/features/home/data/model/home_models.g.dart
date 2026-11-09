// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BannerModel _$BannerModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BannerModel', json, ($checkedConvert) {
      final val = _BannerModel(
        id: $checkedConvert('id', (v) => v as String),
        tag: $checkedConvert('tag', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$BannerModelToJson(_BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
    };

_SectionModel _$SectionModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SectionModel', json, ($checkedConvert) {
      final val = _SectionModel(
        id: $checkedConvert('id', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$HomeSectionTypeEnumMap, v),
        ),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
        productIds: $checkedConvert(
          'productIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SectionModelToJson(_SectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$HomeSectionTypeEnumMap[instance.type]!,
      'sortOrder': instance.sortOrder,
      'productIds': instance.productIds,
    };

const _$HomeSectionTypeEnumMap = {
  HomeSectionType.seasonal: 'seasonal',
  HomeSectionType.popular: 'popular',
  HomeSectionType.orderAgain: 'orderAgain',
};

_ShopModel _$ShopModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ShopModel', json, ($checkedConvert) {
      final val = _ShopModel(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ShopModelToJson(_ShopModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
    };
