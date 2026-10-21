import 'cat.dart';
import 'cats_repository.dart';

/// [CatsRepository] serving a static, in-memory collection of cats.
///
/// Stand-in for a real data source until the backend is available.
class FakeCatsRepository implements CatsRepository {
  const FakeCatsRepository();

  static const List<Cat> _cats = [
    Cat(id: 'onyx', name: 'Onyx', imageUrl: 'assets/cats/onyx.png', rating: 5),
    Cat(
      id: 'raven',
      name: 'Raven',
      imageUrl: 'assets/cats/raven.png',
      rating: 4,
    ),
    Cat(
      id: 'midnight',
      name: 'Midnight',
      imageUrl: 'assets/cats/midnight.png',
      rating: 5,
    ),
    Cat(
      id: 'eclipse',
      name: 'Eclipse',
      imageUrl: 'assets/cats/eclipse.png',
      rating: 3,
    ),
    Cat(id: 'noir', name: 'Noir', imageUrl: 'assets/cats/noir.png', rating: 4),
    Cat(id: 'luna', name: 'Luna', imageUrl: 'assets/cats/luna.png', rating: 2),
    Cat(
      id: 'salem',
      name: 'Salem',
      imageUrl: 'assets/cats/salem.png',
      rating: 1,
    ),
  ];

  @override
  Future<List<Cat>> fetchCats() async => List.unmodifiable(_cats);
}
