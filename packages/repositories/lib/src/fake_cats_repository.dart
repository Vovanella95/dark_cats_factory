import 'cat.dart';
import 'cats_repository.dart';

/// [CatsRepository] serving a static, in-memory collection of cats.
///
/// Stand-in for a real data source until the backend is available.
class FakeCatsRepository implements CatsRepository {
  const FakeCatsRepository();

  static const List<Cat> _cats = [
    Cat(
      id: 'onyx',
      name: 'Onyx',
      imageUrl: 'assets/cats/onyx.png',
      rating: 5,
      description:
          'Onyx is a pure-black show cat with a glossy coat that swallows '
          'the light. Calm, affectionate and always first at the food bowl.',
    ),
    Cat(
      id: 'raven',
      name: 'Raven',
      imageUrl: 'assets/cats/raven.png',
      rating: 4,
      description:
          'Raven is a curious night prowler with big amber eyes. Loves '
          'cardboard boxes, high shelves and long naps in warm laundry.',
    ),
    Cat(
      id: 'midnight',
      name: 'Midnight',
      imageUrl: 'assets/cats/midnight.png',
      rating: 5,
      description:
          'Midnight is the factory veteran: unflappable, dignified and '
          'generous with slow blinks. A loyal companion for quiet evenings.',
    ),
    Cat(
      id: 'eclipse',
      name: 'Eclipse',
      imageUrl: 'assets/cats/eclipse.png',
      rating: 3,
      description:
          'Eclipse has a smoky half-masked face and a playful streak. '
          'Chases anything that rolls and purrs like a small engine.',
    ),
    Cat(
      id: 'noir',
      name: 'Noir',
      imageUrl: 'assets/cats/noir.png',
      rating: 4,
      description:
          'Noir is a brooding gentleman with a velvet-black coat. Prefers '
          'to observe first and head-butt later, on his own strict terms.',
    ),
    Cat(
      id: 'luna',
      name: 'Luna',
      imageUrl: 'assets/cats/luna.png',
      rating: 2,
      description:
          'Luna is a shy moonlit dreamer who warms up slowly. Once she '
          'trusts you, she never leaves your lap.',
    ),
    Cat(
      id: 'salem',
      name: 'Salem',
      imageUrl: 'assets/cats/salem.png',
      rating: 1,
      description:
          'Salem is a chaotic little goblin with one white whisker. '
          'Zero manners, endless energy, absolutely worth it.',
    ),
  ];

  @override
  Future<List<Cat>> fetchCats() async => List.unmodifiable(_cats);
}
