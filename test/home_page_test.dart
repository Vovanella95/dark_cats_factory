import 'dart:async';

import 'package:dark_cats_factory/pages/home_page.dart';
import 'package:dark_cats_factory/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

class _StubNewsRepository implements NewsRepository {
  Completer<List<NewsItem>> _completer = Completer<List<NewsItem>>();

  void succeedWith(List<NewsItem> news) => _completer.complete(news);

  void failWith(Object error) => _completer.completeError(error);

  /// Queues the answer of the next fetch, e.g. after a failed attempt.
  void succeedNextWith(List<NewsItem> news) {
    _completer = Completer<List<NewsItem>>()..complete(news);
  }

  @override
  Future<List<NewsItem>> fetchNews() => _completer.future;
}

final _news = [
  NewsItem(
    id: 'kitten-cam',
    title: 'Kitten cam goes live',
    imageUrl: 'assets/cats/onyx.png',
    summary: 'Watch the newest litter around the clock.',
    publishedAt: DateTime(2025, 5, 12),
  ),
  NewsItem(
    id: 'onyx-wins',
    title: 'Onyx is Cat of the Month',
    imageUrl: 'assets/cats/raven.png',
    summary: 'The judges praised his glossy, light-swallowing coat.',
    publishedAt: DateTime(2025, 5, 10),
  ),
  NewsItem(
    id: 'factory-tour',
    title: 'Factory tours reopen',
    imageUrl: 'assets/cats/luna.png',
    summary: 'Book a guided walk through the shadowy halls.',
    publishedAt: DateTime(2025, 5, 8),
  ),
];

Finder _cardOf(String title) =>
    find.ancestor(of: find.text(title), matching: find.byType(NewsCard));

void main() {
  Future<void> pumpHome(WidgetTester tester, _StubNewsRepository repo) async {
    // Tall enough that every stubbed item fits the viewport and is built by
    // the lazy ListView.
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(800, 2200);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MaterialApp(home: HomePage(repository: repo)));
    await tester.pump();
  }

  testWidgets('shows a progress indicator while news are loading', (
    tester,
  ) async {
    final repository = _StubNewsRepository();
    await pumpHome(tester, repository);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(NewsCard), findsNothing);
  });

  testWidgets('renders a card for every fetched news item', (tester) async {
    final repository = _StubNewsRepository();
    await pumpHome(tester, repository);

    repository.succeedWith(_news);
    await tester.pumpAndSettle();

    expect(find.byType(NewsCard), findsNWidgets(_news.length));
    for (final item in _news) {
      expect(find.text(item.title), findsOneWidget);
    }
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('renders every card with the item image', (tester) async {
    final repository = _StubNewsRepository();
    await pumpHome(tester, repository);

    repository.succeedWith(_news);
    await tester.pumpAndSettle();

    for (final item in _news) {
      final image = find.descendant(
        of: _cardOf(item.title),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == item.imageUrl,
        ),
      );
      expect(image, findsOneWidget, reason: 'no image for ${item.title}');
    }
  });

  testWidgets('renders every card with summary and publication date', (
    tester,
  ) async {
    final repository = _StubNewsRepository();
    await pumpHome(tester, repository);

    repository.succeedWith(_news);
    await tester.pumpAndSettle();

    for (final item in _news) {
      final card = _cardOf(item.title);
      expect(
        find.descendant(of: card, matching: find.text(item.summary)),
        findsOneWidget,
        reason: 'no summary for ${item.title}',
      );
      expect(
        find.descendant(of: card, matching: find.textContaining('2025')),
        findsOneWidget,
        reason: 'no publication date for ${item.title}',
      );
    }
  });

  testWidgets('shows an error message when loading fails', (tester) async {
    final repository = _StubNewsRepository();
    await pumpHome(tester, repository);

    repository.failWith(Exception('boom'));
    await tester.pumpAndSettle();

    expect(find.text('Failed to load news'), findsOneWidget);
    expect(find.byType(NewsCard), findsNothing);
  });

  testWidgets('retries loading when the retry action is tapped', (
    tester,
  ) async {
    final repository = _StubNewsRepository();
    await pumpHome(tester, repository);

    repository.failWith(Exception('boom'));
    await tester.pumpAndSettle();
    expect(find.text('Failed to load news'), findsOneWidget);

    repository.succeedNextWith(_news);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('Failed to load news'), findsNothing);
    expect(find.byType(NewsCard), findsNWidgets(_news.length));
    for (final item in _news) {
      expect(find.text(item.title), findsOneWidget);
    }
  });
}
