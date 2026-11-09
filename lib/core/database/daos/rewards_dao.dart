import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/challenges.dart';
import '../tables/tiers.dart';

part 'rewards_dao.g.dart';

@DriftAccessor(tables: [Tiers, Challenges])
class RewardsDao extends DatabaseAccessor<AppDatabase> with _$RewardsDaoMixin {
  RewardsDao(super.attachedDatabase);

  /// Lowest tier first.
  Stream<List<TierRow>> watchTiers() => (select(
    tiers,
  )..orderBy([(tier) => OrderingTerm(expression: tier.minPoints)])).watch();

  Stream<List<ChallengeRow>> watchChallenges() =>
      (select(challenges)..orderBy([
            (challenge) => OrderingTerm(expression: challenge.sortOrder),
          ]))
          .watch();

  /// Upserts [rows] and removes tiers the new list no longer has.
  Future<void> replaceTiers(List<TierRow> rows) => transaction(() async {
    final ids = rows.map((row) => row.id);
    await (delete(tiers)..where((tier) => tier.id.isNotIn(ids))).go();
    await batch((batch) => batch.insertAllOnConflictUpdate(tiers, rows));
  });

  /// Upserts [rows] and removes challenges the new list no longer has.
  Future<void> replaceChallenges(List<ChallengeRow> rows) =>
      transaction(() async {
        final ids = rows.map((row) => row.id);
        await (delete(
          challenges,
        )..where((challenge) => challenge.id.isNotIn(ids))).go();
        await batch(
          (batch) => batch.insertAllOnConflictUpdate(challenges, rows),
        );
      });
}
