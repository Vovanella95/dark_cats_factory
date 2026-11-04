import 'package:dark_cats_factory/pages/collection_item_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

import 'golden_test_helpers.dart';

void main() {
  testWidgets('collection item details page matches the golden', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    const cat = Cat(
      id: 'onyx',
      name: 'Onyx',
      imageUrl: 'assets/cats/onyx.png',
      rating: 5,
      description:
          'Onyx is a pure-black show cat with a glossy coat that swallows '
          'the light. Calm, affectionate and always first at the food bowl.',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: CollectionItemDetailsPage(
          cat: cat,
          onDelete: () {},
          onShare: () {},
        ),
      ),
    );

    // Decode the picture before settling, so the page is painted with the
    // loaded image instead of racing the golden capture.
    await tester.runAsync(() async {
      await waitForImage(AssetImage(cat.imageUrl));
    });

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CollectionItemDetailsPage),
      matchesGoldenFile('goldens/collection_item_details_page.png'),
    );
  });
}
