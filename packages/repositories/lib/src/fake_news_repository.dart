import 'news_item.dart';
import 'news_repository.dart';

/// [NewsRepository] serving a static, in-memory news feed.
///
/// Stand-in for a real data source until the backend is available; the
/// covers reuse the bundled cat assets.
class FakeNewsRepository implements NewsRepository {
  const FakeNewsRepository();

  static final List<NewsItem> _news = [
    NewsItem(
      id: 'kitten-cam',
      title: 'Kitten cam goes live',
      imageUrl: 'assets/cats/onyx.png',
      summary:
          'The newest litter now has a round-the-clock stream. Expect '
          'wobbling paws, accidental pile-ups and a lot of unsupervised '
          'mischief in the nursery wing.',
      publishedAt: DateTime(2025, 5, 12),
    ),
    NewsItem(
      id: 'onyx-of-the-month',
      title: 'Onyx is Cat of the Month',
      imageUrl: 'assets/cats/raven.png',
      summary:
          'The judges praised his glossy, light-swallowing coat and his '
          'unshakable show-floor composure. Onyx accepted the title with '
          'a slow blink.',
      publishedAt: DateTime(2025, 5, 10),
    ),
    NewsItem(
      id: 'night-shift-report',
      title: 'Night shift report: zero mice',
      imageUrl: 'assets/cats/midnight.png',
      summary:
          'The veteran patrol kept every hall clear again. Management '
          'thanks the team and has promised an extra bowl of the good '
          'food.',
      publishedAt: DateTime(2025, 5, 8),
    ),
    NewsItem(
      id: 'factory-tours',
      title: 'Factory tours reopen',
      imageUrl: 'assets/cats/eclipse.png',
      summary:
          'Guided walks through the shadowy production halls are back. '
          'Visitors are warned: Eclipse has been rehearsing ambushes '
          'along the whole route.',
      publishedAt: DateTime(2025, 5, 6),
    ),
    NewsItem(
      id: 'luna-merch',
      title: 'Luna-approved blankets in stock',
      imageUrl: 'assets/cats/luna.png',
      summary:
          'The nap laboratory certified a new batch of extra-soft '
          'blankets. Luna slept on every single one before signing off.',
      publishedAt: DateTime(2025, 5, 4),
    ),
    NewsItem(
      id: 'salem-incident',
      title: 'Salem incident: one broken vase',
      imageUrl: 'assets/cats/salem.png',
      summary:
          'The investigation is ongoing, but early reports point to a '
          'chaotic little goblin with one white whisker. No regrets were '
          'detected at the scene.',
      publishedAt: DateTime(2025, 5, 2),
    ),
  ];

  @override
  Future<List<NewsItem>> fetchNews() async => List.unmodifiable(_news);
}
