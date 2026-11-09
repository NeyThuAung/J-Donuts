// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_dao.dart';

// ignore_for_file: type=lint
mixin _$RewardsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TiersTable get tiers => attachedDatabase.tiers;
  $ChallengesTable get challenges => attachedDatabase.challenges;
  RewardsDaoManager get managers => RewardsDaoManager(this);
}

class RewardsDaoManager {
  final _$RewardsDaoMixin _db;
  RewardsDaoManager(this._db);
  $$TiersTableTableManager get tiers =>
      $$TiersTableTableManager(_db.attachedDatabase, _db.tiers);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db.attachedDatabase, _db.challenges);
}
