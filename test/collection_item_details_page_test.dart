import 'package:dark_cats_factory/pages/collection_item_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

const _cat = Cat(
  id: 'onyx',
  name: 'Onyx',
  imageUrl: 'assets/cats/onyx.png',
  rating: 5,
  description: 'A glossy black show cat that swallows the light.',
);

Future<void> pumpDetails(
  WidgetTester tester, {
  Cat cat = _cat,
  VoidCallback? onDelete,
  VoidCallback? onShare,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: CollectionItemDetailsPage(
        cat: cat,
        onDelete: onDelete,
        onShare: onShare,
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('shows the cat image', (tester) async {
    await pumpDetails(tester);

    final image = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName == _cat.imageUrl,
    );
    expect(image, findsOneWidget);
  });

  testWidgets('shows the cat name', (tester) async {
    await pumpDetails(tester);

    expect(find.text(_cat.name), findsOneWidget);
  });

  testWidgets('shows the cat rating as 1-5 stars', (tester) async {
    await pumpDetails(tester, cat: _cat);

    expect(find.byIcon(Icons.star), findsNWidgets(5));
    expect(find.byIcon(Icons.star_border), findsNWidgets(0));

    await pumpDetails(tester, cat: _twoStarCat);

    expect(find.byIcon(Icons.star), findsNWidgets(2));
    expect(find.byIcon(Icons.star_border), findsNWidgets(3));
  });

  testWidgets('shows the cat description', (tester) async {
    await pumpDetails(tester);

    expect(find.text(_cat.description), findsOneWidget);
  });

  testWidgets('shows Delete and Share buttons at the bottom', (tester) async {
    await pumpDetails(tester);

    final delete = find.widgetWithText(FilledButton, 'Delete');
    final share = find.widgetWithText(FilledButton, 'Share');
    expect(delete, findsOneWidget);
    expect(share, findsOneWidget);

    // Both buttons sit at the bottom of the page.
    final viewHeight = tester.view.physicalSize.height /
        tester.view.devicePixelRatio;
    expect(
      tester.getBottomRight(delete).dy,
      greaterThan(viewHeight / 2),
      reason: 'Delete should be in the bottom half of the screen',
    );
    expect(
      tester.getBottomRight(share).dy,
      greaterThan(viewHeight / 2),
      reason: 'Share should be in the bottom half of the screen',
    );
  });

  testWidgets('tapping Delete invokes the delete callback', (tester) async {
    var deleted = false;
    await pumpDetails(tester, onDelete: () => deleted = true);

    await tester.tap(find.text('Delete'));
    await tester.pump();

    expect(deleted, isTrue);
  });

  testWidgets('tapping Share invokes the share callback', (tester) async {
    var shared = false;
    await pumpDetails(tester, onShare: () => shared = true);

    await tester.tap(find.text('Share'));
    await tester.pump();

    expect(shared, isTrue);
  });
}

const _twoStarCat = Cat(
  id: 'luna',
  name: 'Luna',
  imageUrl: 'assets/cats/luna.png',
  rating: 2,
  description: 'A shy moonlit dreamer.',
);
