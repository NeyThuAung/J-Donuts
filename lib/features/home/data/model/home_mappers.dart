import '../../../../core/database/database.dart';
import '../../../../core/image/image_ref_resolver.dart';
import '../../domain/entity/banner_entity.dart';
import '../../domain/entity/home_section_entity.dart';
import '../../domain/entity/home_section_type.dart';
import '../../domain/entity/shop_entity.dart';
import 'home_models.dart';

extension BannerModelMapper on BannerModel {
  BannerRow toRow() => BannerRow(
    id: id,
    tag: tag,
    title: title,
    imageUrl: imageUrl,
    sortOrder: sortOrder,
  );
}

extension BannerRowMapper on BannerRow {
  BannerEntity toEntity(ImageRefResolver images) => BannerEntity(
    id: id,
    tag: tag,
    title: title,
    image: images.resolve(imageUrl),
  );
}

extension ShopModelMapper on ShopModel {
  ShopRow toRow() => ShopRow(
    id: id,
    name: name,
    address: address,
    imageUrl: imageUrl,
    sortOrder: sortOrder,
  );
}

extension ShopRowMapper on ShopRow {
  ShopEntity toEntity(ImageRefResolver images) => ShopEntity(
    id: id,
    name: name,
    address: address,
    image: images.resolve(imageUrl),
  );
}

extension SectionModelMapper on SectionModel {
  SectionRow toRow() =>
      SectionRow(id: id, type: type.name, sortOrder: sortOrder);

  List<SectionProductRow> toLinks() => [
    for (final (index, productId) in productIds.indexed)
      SectionProductRow(sectionId: id, productId: productId, sortOrder: index),
  ];
}

extension SectionWithProductIdsMapper on SectionWithProductIds {
  HomeSectionLayout toLayout() => HomeSectionLayout(
    id: section.id,
    type: HomeSectionType.values.byName(section.type),
    productIds: productIds,
  );
}
