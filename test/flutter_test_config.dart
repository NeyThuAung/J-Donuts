import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:j_donuts/gen/fonts.gen.dart';

// Loads the app's bundled fonts so layout tests (small phone, text scale 1.3,
// Burmese) measure real text instead of the square test glyphs.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await _loadFont(FontFamily.figtree, 'Figtree');
  await _loadFont(FontFamily.notoSansMyanmar, 'NotoSansMyanmar');
  await testMain();
}

Future<void> _loadFont(String family, String filePrefix) async {
  final loader = FontLoader(family);
  final files = Directory('assets/fonts')
      .listSync()
      .whereType<File>()
      .where((file) => file.uri.pathSegments.last.startsWith('$filePrefix-'))
      .where((file) => file.path.endsWith('.ttf'));
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(file.readAsBytesSync())),
    );
  }
  await loader.load();
}
