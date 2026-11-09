import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/image/image_ref.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    required bool isNew,

    /// Shown as a badge; null when there is no discount.
    int? discountPercent,
    required ImageRef image,
    required String description,
  }) = _ProductEntity;
}
