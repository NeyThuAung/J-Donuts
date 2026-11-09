import 'package:drift/drift.dart';

import 'app_database.steps.dart';
import 'daos/app_meta_dao.dart';
import 'daos/home_dao.dart';
import 'daos/members_dao.dart';
import 'daos/products_dao.dart';
import 'daos/users_dao.dart';
import 'tables/app_meta_entries.dart';
import 'tables/banners.dart';
import 'tables/members.dart';
import 'tables/products.dart';
import 'tables/sections.dart';
import 'tables/shops.dart';
import 'tables/users.dart';

part 'app_database.g.dart';

// Every schema change bumps schemaVersion and adds a tested migration step.
@DriftDatabase(
  tables: [
    AppMetaEntries,
    Users,
    Products,
    Banners,
    Sections,
    SectionProducts,
    Shops,
    Members,
  ],
  daos: [AppMetaDao, UsersDao, ProductsDao, HomeDao, MembersDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: stepByStep(
      from1To2: (migrator, schema) => migrator.createTable(schema.users),
      from2To3: _addCatalog,
    ),
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );

  Future<void> _addCatalog(Migrator migrator, Schema3 schema) async {
    await migrator.createTable(schema.products);
    await migrator.createTable(schema.banners);
    await migrator.createTable(schema.sections);
    await migrator.createTable(schema.sectionProducts);
    await migrator.createTable(schema.shops);
    await migrator.createTable(schema.members);
  }
}
