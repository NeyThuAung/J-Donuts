import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_donuts/core/core.dart';
import 'package:j_donuts/l10n/l10n.dart';

class _OtherFailure extends Failure {
  const _OtherFailure() : super('other');
}

void main() {
  final en = lookupAppLocalizations(const Locale('en'));
  final my = lookupAppLocalizations(const Locale('my'));

  group('Failure.message', () {
    final cases = <Failure, String>{
      const ConnectionFailure(): en.errorNoConnection,
      const TimeoutFailure(): en.errorTimeout,
      const NotFoundFailure(): en.errorNotFound,
      const BadRequestFailure(): en.errorBadRequest,
      const SessionFailure(): en.errorSessionExpired,
      const ServerFailure(): en.errorServer,
      const CacheFailure(): en.errorStorage,
      const UnknownFailure(): en.errorUnknown,
    };

    cases.forEach((failure, text) {
      test('maps ${failure.runtimeType} to its message', () {
        expect(failure.message(en), text);
      });
    });

    test('falls back to the unknown message for unmapped failures', () {
      expect(const _OtherFailure().message(en), en.errorUnknown);
    });

    test('returns Burmese text for the my locale', () {
      expect(const ConnectionFailure().message(my), my.errorNoConnection);
      expect(my.errorNoConnection, isNot(en.errorNoConnection));
    });
  });

  test('supports English and Burmese', () {
    expect(
      AppLocalizations.supportedLocales.map((l) => l.languageCode),
      containsAll(['en', 'my']),
    );
  });
}
