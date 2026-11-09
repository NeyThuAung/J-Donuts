import '../../../l10n/l10n.dart';
import '../domain/entity/member_tier.dart';

// Display name of a tier; Home and Rewards both show it.
extension MemberTierLabel on MemberTier {
  String label(AppLocalizations l10n) => switch (this) {
    MemberTier.silver => l10n.memberTierSilver,
    MemberTier.gold => l10n.memberTierGold,
    MemberTier.platinum => l10n.memberTierPlatinum,
  };
}
