import 'dart:async';

import 'package:blocks/blocks.dart';
import 'package:dark_cats_factory/l10n/app_localizations.dart';
import 'package:dark_cats_factory/pages/collection_item_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

/// Waits until [provider] delivers a decoded image.
///
/// Mirrors the helper in `collection_page_golden_test.dart`: the codec runs
/// on the real event loop, so this must be called inside
/// [WidgetTester.runAsync].
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
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: appSupportedLocales,
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
      await _waitForImage(AssetImage(cat.imageUrl));
    });

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CollectionItemDetailsPage),
      matchesGoldenFile('goldens/collection_item_details_page.png'),
    );
  });
}
