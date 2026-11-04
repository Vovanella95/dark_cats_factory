import 'package:dark_cats_factory/pages/collection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

import 'golden_test_helpers.dart';

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
        for (final cat in cats) waitForImage(AssetImage(cat.imageUrl)),
      ]);
    });

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CollectionPage),
      matchesGoldenFile('goldens/collection_page.png'),
    );
  });
}
