import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

void main() {
  group('FakeNewsRepository', () {
    const repository = FakeNewsRepository();

    test('provides a non-empty news feed', () async {
      final news = await repository.fetchNews();

      expect(news, isNotEmpty);
      expect(news.length, greaterThanOrEqualTo(2));
    });

    test(
      'provides news items with unique ids, titles, images and summaries',
      () async {
        final news = await repository.fetchNews();

        expect(news.map((item) => item.id).toSet(), hasLength(news.length));
        for (final item in news) {
          expect(
            item.title,
            isNotEmpty,
            reason: 'news ${item.id} has no title',
          );
          expect(
            item.imageUrl,
            isNotEmpty,
            reason: 'news ${item.id} has no image',
          );
          expect(
            item.summary,
            isNotEmpty,
            reason: 'news ${item.id} has no summary',
          );
        }
      },
    );

    test('orders the feed from newest to oldest', () async {
      final news = await repository.fetchNews();

      for (var i = 1; i < news.length; i++) {
        expect(
          news[i].publishedAt.isBefore(news[i - 1].publishedAt),
          isTrue,
          reason:
              '${news[i].id} (${news[i].publishedAt}) is not older than '
              '${news[i - 1].id} (${news[i - 1].publishedAt})',
        );
      }
    });

    test('returns an equal feed on every call', () async {
      final first = await repository.fetchNews();
      final second = await repository.fetchNews();

      expect(first, equals(second));
      expect(identical(first, second), isFalse);
    });
  });
}
