import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

// Shape of one item in /v1/products.json data (brief p.7).
@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    @Default(false) bool isNew,
    int? discountPercent,
    required String imageUrl,
    required String description,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

List<ProductModel> productsFromJson(Object? json) => (json! as List<Object?>)
    .map((item) => ProductModel.fromJson(item! as Map<String, dynamic>))
    .toList();
