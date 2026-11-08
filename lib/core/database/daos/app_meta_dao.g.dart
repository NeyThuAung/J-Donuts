// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_meta_dao.dart';

// ignore_for_file: type=lint
mixin _$AppMetaDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppMetaEntriesTable get appMetaEntries => attachedDatabase.appMetaEntries;
  AppMetaDaoManager get managers => AppMetaDaoManager(this);
}

class AppMetaDaoManager {
  final _$AppMetaDaoMixin _db;
  AppMetaDaoManager(this._db);
  $$AppMetaEntriesTableTableManager get appMetaEntries =>
      $$AppMetaEntriesTableTableManager(
        _db.attachedDatabase,
        _db.appMetaEntries,
      );
}
