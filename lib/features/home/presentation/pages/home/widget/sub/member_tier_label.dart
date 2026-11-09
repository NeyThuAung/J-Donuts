import '../../../../../../../l10n/l10n.dart';
import '../../../../../../member/domain/entity/member_tier.dart';

extension MemberTierLabel on MemberTier {
  String label(AppLocalizations l10n) => switch (this) {
    MemberTier.silver => l10n.memberTierSilver,
    MemberTier.gold => l10n.memberTierGold,
    MemberTier.platinum => l10n.memberTierPlatinum,
  };
}
