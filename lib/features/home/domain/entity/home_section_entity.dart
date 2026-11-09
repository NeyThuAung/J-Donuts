import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../product/domain/entity/product_entity.dart';
import 'home_section_type.dart';

part 'home_section_entity.freezed.dart';

/// Which products a section shows, in order, as stored.
@freezed
abstract class HomeSectionLayout with _$HomeSectionLayout {
  const factory HomeSectionLayout({
    required String id,
    required HomeSectionType type,
    required List<String> productIds,
  }) = _HomeSectionLayout;
}

/// A section ready to show; empty [products] shows the section's empty state.
@freezed
abstract class HomeSectionEntity with _$HomeSectionEntity {
  const factory HomeSectionEntity({
    required String id,
    required HomeSectionType type,
    required List<ProductEntity> products,
  }) = _HomeSectionEntity;
}
