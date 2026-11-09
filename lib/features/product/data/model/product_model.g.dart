// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ProductModel', json, ($checkedConvert) {
      final val = _ProductModel(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        priceMmk: $checkedConvert('priceMmk', (v) => (v as num).toInt()),
        isNew: $checkedConvert('isNew', (v) => v as bool? ?? false),
        discountPercent: $checkedConvert(
          'discountPercent',
          (v) => (v as num?)?.toInt(),
        ),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'priceMmk': instance.priceMmk,
      'isNew': instance.isNew,
      'discountPercent': instance.discountPercent,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
