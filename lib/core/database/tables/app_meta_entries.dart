import 'package:drift/drift.dart';

// Non-secret app flags as key-value pairs; the session lives in secure storage.
@DataClassName('AppMetaEntry')
class AppMetaEntries extends Table {
  @override
  String get tableName => 'app_meta';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
