import 'package:dark_cats_factory/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

import 'golden_test_helpers.dart';

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
        for (final item in news) waitForImage(AssetImage(item.imageUrl)),
      ]);
    });

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomePage),
      matchesGoldenFile('goldens/home_page.png'),
    );
  });
}
