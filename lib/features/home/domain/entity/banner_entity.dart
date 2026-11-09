import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/image/image_ref.dart';

part 'banner_entity.freezed.dart';

@freezed
abstract class BannerEntity with _$BannerEntity {
  const factory BannerEntity({
    required String id,
    required String tag,
    required String title,
    required ImageRef image,
  }) = _BannerEntity;
}
