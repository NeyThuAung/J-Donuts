import 'package:flutter/widgets.dart';

import 'gen/app_localizations.dart';

export 'failure_message.dart';
export 'gen/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
