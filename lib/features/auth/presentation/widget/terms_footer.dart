import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/styles/styles.dart';

// The notice is one translated sentence; the links are cut out of it by
// marker, so each language keeps its own word order.
const _termsMarker = '{terms}';
const _privacyMarker = '{privacy}';
final _markerPattern = RegExp(
  '${RegExp.escape(_termsMarker)}|${RegExp.escape(_privacyMarker)}',
);

class TermsFooter extends StatelessWidget {
  const TermsFooter({
    super.key,
    required this.onTermsTap,
    required this.onPrivacyTap,
  });

  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final notice = l10n.authTermsNotice(_termsMarker, _privacyMarker);
    final spans = <InlineSpan>[];
    var start = 0;
    for (final match in _markerPattern.allMatches(notice)) {
      spans
        ..add(TextSpan(text: notice.substring(start, match.start)))
        ..add(_link(match[0] == _termsMarker));
      start = match.end;
    }
    spans.add(TextSpan(text: notice.substring(start)));
    return Text.rich(
      TextSpan(children: spans),
      textAlign: TextAlign.center,
      style: context.textTheme.bodySmall?.copyWith(
        color: context.appColors.textSecondary,
      ),
    );
  }

  InlineSpan _link(bool isTerms) => WidgetSpan(
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    child: _Link(
      isTerms: isTerms,
      onTap: isTerms ? onTermsTap : onPrivacyTap,
    ),
  );
}

class _Link extends StatelessWidget {
  const _Link({required this.isTerms, required this.onTap});

  final bool isTerms;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      link: true,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          isTerms ? l10n.authTermsOfUse : l10n.authPrivacyPolicy,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.appColors.accent,
          ),
        ),
      ),
    );
  }
}
