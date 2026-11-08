import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/app_meta_entries.dart';

part 'app_meta_dao.g.dart';

@DriftAccessor(tables: [AppMetaEntries])
class AppMetaDao extends DatabaseAccessor<AppDatabase> with _$AppMetaDaoMixin {
  AppMetaDao(super.attachedDatabase);

  Future<String?> readValue(String key) => _valueOf(key).getSingleOrNull();

  Stream<String?> watchValue(String key) => _valueOf(key).watchSingleOrNull();

  Future<void> writeValue(String key, String value) =>
      into(
        appMetaEntries,
      ).insertOnConflictUpdate(
        AppMetaEntriesCompanion.insert(key: key, value: value),
      );

  Future<void> removeValue(String key) =>
      (delete(appMetaEntries)..where((entry) => entry.key.equals(key))).go();

  Selectable<String> _valueOf(String key) =>
      (select(appMetaEntries)..where((entry) => entry.key.equals(key))).map(
        (entry) => entry.value,
      );
}
