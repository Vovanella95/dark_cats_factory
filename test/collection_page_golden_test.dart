import 'dart:async';

import 'package:dark_cats_factory/pages/collection_page.dart';
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
  provider.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener(
      (_, _) => completer.complete(),
      onError: (Object error, StackTrace? stackTrace) =>
          completer.completeError(error, stackTrace),
    ),
  );
  return completer.future;
}

void main() {
  testWidgets('collection page matches the golden', (tester) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: CollectionPage()));

    // Decode every fake cat picture before settling, so the grid is painted
    // with the loaded images instead of racing the golden capture.
    await tester.runAsync(() async {
      final cats = await const FakeCatsRepository().fetchCats();
      await Future.wait([
        for (final cat in cats) _waitForImage(AssetImage(cat.imageUrl)),
      ]);
    });

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CollectionPage),
      matchesGoldenFile('goldens/collection_page.png'),
    );
  });
}
