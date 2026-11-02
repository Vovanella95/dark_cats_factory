import 'dart:async';

import 'package:dark_cats_factory/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

/// Waits until [provider] delivers a decoded image.
///
/// The image codec runs on the real event loop, which fake async cannot
/// drive, so this must be called inside [WidgetTester.runAsync]. Waiting
/// also warms the image cache, so later [Image]s paint without a race.
Future<void> _waitForImage(ImageProvider provider) {
  final completer = Completer<void>();
  provider
      .resolve(const ImageConfiguration())
      .addListener(
        ImageStreamListener(
          (_, _) => completer.complete(),
          onError: (Object error, StackTrace? stackTrace) =>
              completer.completeError(error, stackTrace),
        ),
      );
  return completer.future;
}

void main() {
  testWidgets('home page matches the golden', (tester) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Decode every fake news picture before settling, so the feed is painted
    // with the loaded images instead of racing the golden capture.
    await tester.runAsync(() async {
      final news = await const FakeNewsRepository().fetchNews();
      await Future.wait([
        for (final item in news) _waitForImage(AssetImage(item.imageUrl)),
      ]);
    });

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomePage),
      matchesGoldenFile('goldens/home_page.png'),
    );
  });
}
