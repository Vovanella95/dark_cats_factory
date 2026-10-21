import 'dart:async';

import 'package:dark_cats_factory/pages/collection_page.dart';
import 'package:dark_cats_factory/widgets/cat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

class _StubCatsRepository implements CatsRepository {
  final Completer<List<Cat>> _completer = Completer<List<Cat>>();

  void succeedWith(List<Cat> cats) => _completer.complete(cats);

  void failWith(Object error) => _completer.completeError(error);

  @override
  Future<List<Cat>> fetchCats() => _completer.future;
}

const _cats = [
  Cat(id: 'onyx', name: 'Onyx', imageUrl: 'assets/cats/onyx.png', rating: 5),
  Cat(id: 'salem', name: 'Salem', imageUrl: 'assets/cats/salem.png', rating: 1),
  Cat(id: 'luna', name: 'Luna', imageUrl: 'assets/cats/luna.png', rating: 2),
];

Finder _cardOf(String name) =>
    find.ancestor(of: find.text(name), matching: find.byType(CatCard));

void main() {
  Future<void> pumpCollection(WidgetTester tester, _StubCatsRepository repo) async {
    await tester.pumpWidget(MaterialApp(home: CollectionPage(repository: repo)));
    await tester.pump();
  }

  testWidgets('shows a progress indicator while cats are loading', (tester) async {
    final repository = _StubCatsRepository();
    await pumpCollection(tester, repository);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(CatCard), findsNothing);
  });

  testWidgets('renders a card for every fetched cat', (tester) async {
    final repository = _StubCatsRepository();
    await pumpCollection(tester, repository);

    repository.succeedWith(_cats);
    await tester.pumpAndSettle();

    expect(find.byType(CatCard), findsNWidgets(_cats.length));
    for (final cat in _cats) {
      expect(find.text(cat.name), findsOneWidget);
    }
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('renders every card with the cat image', (tester) async {
    final repository = _StubCatsRepository();
    await pumpCollection(tester, repository);

    repository.succeedWith(_cats);
    await tester.pumpAndSettle();

    for (final cat in _cats) {
      final image = find.descendant(
        of: _cardOf(cat.name),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == cat.imageUrl,
        ),
      );
      expect(image, findsOneWidget, reason: 'no image for ${cat.name}');
    }
  });

  testWidgets('renders every card with a 1-5 star rating', (tester) async {
    final repository = _StubCatsRepository();
    await pumpCollection(tester, repository);

    repository.succeedWith(_cats);
    await tester.pumpAndSettle();

    final onyxStars = find.descendant(
      of: _cardOf('Onyx'),
      matching: find.byIcon(Icons.star),
    );
    final salemStars = find.descendant(
      of: _cardOf('Salem'),
      matching: find.byIcon(Icons.star),
    );
    final salemEmpty = find.descendant(
      of: _cardOf('Salem'),
      matching: find.byIcon(Icons.star_border),
    );

    expect(onyxStars, findsNWidgets(5));
    expect(salemStars, findsOneWidget);
    expect(salemEmpty, findsNWidgets(4));
  });

  testWidgets('shows an error message when loading fails', (tester) async {
    final repository = _StubCatsRepository();
    await pumpCollection(tester, repository);

    repository.failWith(Exception('boom'));
    await tester.pumpAndSettle();

    expect(find.text('Failed to load cats'), findsOneWidget);
    expect(find.byType(CatCard), findsNothing);
  });
}
