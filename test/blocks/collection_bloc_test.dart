import 'package:blocks/blocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

class _FailingCatsRepository implements CatsRepository {
  @override
  Future<List<Cat>> fetchCats() async => throw Exception('boom');
}

void main() {
  group('CollectionBloc', () {
    test('starts in the initial state', () {
      final bloc = CollectionBloc(repository: FakeCatsRepository());

      expect(bloc.state, const CollectionInitial());
    });

    test('emits loading and then the fetched cats on start', () async {
      const repository = FakeCatsRepository();
      final bloc = CollectionBloc(repository: repository);
      final states = <CollectionState>[];
      bloc.stream.listen(states.add);

      bloc.add(const CollectionStarted());
      await bloc.close();

      expect(states, [
        const CollectionLoadInProgress(),
        CollectionLoadSuccess(await repository.fetchCats()),
      ]);
    });

    test(
      'emits loading and then a failure when the repository fails',
      () async {
        final bloc = CollectionBloc(repository: _FailingCatsRepository());
        final states = <CollectionState>[];
        bloc.stream.listen(states.add);

        bloc.add(const CollectionStarted());
        await bloc.close();

        expect(states, [
          const CollectionLoadInProgress(),
          isA<CollectionLoadFailure>().having(
            (state) => state.error,
            'error',
            isException,
          ),
        ]);
      },
    );
  });
}
