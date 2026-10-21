import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the real Roboto faces before any test file runs.
///
/// Widget tests render text with the synthetic `FlutterTest` font, which
/// paints every glyph as a solid box, so golden captures showed squares
/// instead of letters. Loading the fonts checked into `test/fonts/` under
/// the `Roboto` family — the family Material resolves on the default
/// (Android) test platform — makes goldens deterministic and readable.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await _loadFont('Roboto', 'test/fonts/Roboto-Regular.ttf');
  await _loadFont('Roboto', 'test/fonts/Roboto-Medium.ttf');
  await testMain();
}

Future<void> _loadFont(String family, String path) async {
  final bytes = File(path).readAsBytesSync();
  final loader = FontLoader(family)
    ..addFont(Future<void>.value(ByteData.view(bytes.buffer)));
  await loader.load();
}
