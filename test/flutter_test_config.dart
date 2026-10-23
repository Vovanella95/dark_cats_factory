import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the real fonts before any test file runs.
///
/// Widget tests render text with the synthetic `FlutterTest` font, which
/// paints every glyph as a solid box, so golden captures showed squares
/// instead of letters and icons. Loading the fonts here — before any test
/// paints — makes goldens deterministic and readable:
///
/// * icon fonts (MaterialIcons, CupertinoIcons) come from the asset bundle
///   manifest the tool generates from the pubspec;
/// * the Roboto faces checked into `test/fonts/` are read straight from the
///   repository, because `rootBundle` only serves declared assets. Roboto is
///   the family Material resolves on the default (Android) test platform.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await _loadManifestFonts();
  await _loadRoboto();
  await testMain();
}

Future<void> _loadManifestFonts() async {
  final manifest = jsonDecode(
    await rootBundle.loadString('FontManifest.json'),
  ) as List<dynamic>;
  for (final family in manifest.cast<Map<String, dynamic>>()) {
    final name = family['family']! as String;
    final loader = FontLoader(name);
    for (final font
        in (family['fonts']! as List<dynamic>).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset']! as String));
    }
    await loader.load();
  }
}

Future<void> _loadRoboto() async {
  final loader = FontLoader('Roboto')
    ..addFont(_fontData('test/fonts/Roboto-Regular.ttf'))
    ..addFont(_fontData('test/fonts/Roboto-Medium.ttf'));
  await loader.load();
}

Future<ByteData> _fontData(String path) async {
  final bytes = File(path).readAsBytesSync();
  return Future<ByteData>.value(ByteData.view(bytes.buffer));
}
