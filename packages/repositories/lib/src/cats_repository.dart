import 'cat.dart';

/// Source of the cats offered by the factory.
abstract interface class CatsRepository {
  /// Fetches the full collection of cats.
  Future<List<Cat>> fetchCats();
}
