import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

void main() {
  group('FakeCatsRepository', () {
    const repository = FakeCatsRepository();

    test('provides a non-empty collection of cats', () async {
      final cats = await repository.fetchCats();

      expect(cats, isNotEmpty);
      expect(cats.length, greaterThanOrEqualTo(2));
    });

    test(
      'provides cats with unique ids, names, images and 1-5 ratings',
      () async {
        final cats = await repository.fetchCats();

        expect(cats.map((cat) => cat.id).toSet(), hasLength(cats.length));
        for (final cat in cats) {
          expect(cat.name, isNotEmpty, reason: 'cat ${cat.id} has no name');
          expect(
            cat.imageUrl,
            isNotEmpty,
            reason: 'cat ${cat.id} has no image',
          );
          expect(
            cat.rating,
            inInclusiveRange(1, 5),
            reason: 'cat ${cat.id} has an out-of-range rating',
          );
          expect(
            cat.description,
            isNotEmpty,
            reason: 'cat ${cat.id} has no description',
          );
        }
      },
    );

    test('covers every rating from 1 to 5 across the collection', () async {
      final cats = await repository.fetchCats();

      expect(
        cats.map((cat) => cat.rating).toSet(),
        containsAll([1, 2, 3, 4, 5]),
      );
    });

    test('returns an equal collection on every call', () async {
      final first = await repository.fetchCats();
      final second = await repository.fetchCats();

      expect(first, equals(second));
      expect(identical(first, second), isFalse);
    });
  });
}
