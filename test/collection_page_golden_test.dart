import 'package:dark_cats_factory/pages/collection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('collection page matches the golden', (tester) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    // runAsync lets the real image codec decode the asset pictures, which
    // fake async cannot drive.
    await tester.runAsync(() async {
      await tester.pumpWidget(const MaterialApp(home: CollectionPage()));
      await tester.pumpAndSettle();
    });

    await expectLater(
      find.byType(CollectionPage),
      matchesGoldenFile('goldens/collection_page.png'),
    );
  });
}
