import 'package:drift/drift.dart';

// Home carousel banners; added in v3.
@DataClassName('BannerRow')
class Banners extends Table {
  TextColumn get id => text()();
  TextColumn get tag => text()();
  TextColumn get title => text()();
  TextColumn get imageUrl => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
