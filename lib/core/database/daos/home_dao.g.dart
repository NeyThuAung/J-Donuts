// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dao.dart';

// ignore_for_file: type=lint
mixin _$HomeDaoMixin on DatabaseAccessor<AppDatabase> {
  $BannersTable get banners => attachedDatabase.banners;
  $SectionsTable get sections => attachedDatabase.sections;
  $ProductsTable get products => attachedDatabase.products;
  $SectionProductsTable get sectionProducts => attachedDatabase.sectionProducts;
  $ShopsTable get shops => attachedDatabase.shops;
  HomeDaoManager get managers => HomeDaoManager(this);
}

class HomeDaoManager {
  final _$HomeDaoMixin _db;
  HomeDaoManager(this._db);
  $$BannersTableTableManager get banners =>
      $$BannersTableTableManager(_db.attachedDatabase, _db.banners);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db.attachedDatabase, _db.sections);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$SectionProductsTableTableManager get sectionProducts =>
      $$SectionProductsTableTableManager(
        _db.attachedDatabase,
        _db.sectionProducts,
      );
  $$ShopsTableTableManager get shops =>
      $$ShopsTableTableManager(_db.attachedDatabase, _db.shops);
}
