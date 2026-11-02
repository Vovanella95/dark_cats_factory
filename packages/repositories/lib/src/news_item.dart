import 'package:equatable/equatable.dart';

/// A single entry of the home screen news feed.
final class NewsItem extends Equatable {
  const NewsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.publishedAt,
  });

  /// Unique identifier of the news item.
  final String id;

  /// Headline of the news item.
  final String title;

  /// Path or URL of the item's cover image.
  final String imageUrl;

  /// Short teaser text shown under the title.
  final String summary;

  /// When the item was published.
  final DateTime publishedAt;

  @override
  List<Object?> get props => [id, title, imageUrl, summary, publishedAt];
}
