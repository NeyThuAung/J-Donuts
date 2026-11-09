import '../../../../core/database/database.dart';
import '../../../../core/image/image_ref_resolver.dart';
import '../../domain/entity/product_entity.dart';
import 'product_model.dart';

extension ProductModelMapper on ProductModel {
  ProductRow toRow() => ProductRow(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    discountPercent: discountPercent,
    imageUrl: imageUrl,
    description: description,
  );
}

extension ProductRowMapper on ProductRow {
  ProductEntity toEntity(ImageRefResolver images) => ProductEntity(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    discountPercent: discountPercent,
    image: images.resolve(imageUrl),
    description: description,
  );
}
