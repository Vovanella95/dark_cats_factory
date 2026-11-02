import 'news_item.dart';

/// Source of the news feed shown on the home screen.
abstract interface class NewsRepository {
  /// Fetches the news feed, ordered from newest to oldest.
  Future<List<NewsItem>> fetchNews();
}
