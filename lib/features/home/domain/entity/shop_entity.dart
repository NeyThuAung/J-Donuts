import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/image/image_ref.dart';

part 'shop_entity.freezed.dart';

@freezed
abstract class ShopEntity with _$ShopEntity {
  const factory ShopEntity({
    required String id,
    required String name,
    required String address,
    required ImageRef image,
  }) = _ShopEntity;
}
