import 'package:blocks/blocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

class _FailingNewsRepository implements NewsRepository {
  @override
  Future<List<NewsItem>> fetchNews() async => throw Exception('boom');
}

void main() {
  group('NewsBloc', () {
    test('starts in the initial state', () {
      final bloc = NewsBloc(repository: FakeNewsRepository());

      expect(bloc.state, const NewsInitial());
    });

    test('emits loading and then the fetched news on start', () async {
      const repository = FakeNewsRepository();
      final bloc = NewsBloc(repository: repository);
      final states = <NewsState>[];
      bloc.stream.listen(states.add);

      bloc.add(const NewsStarted());
      await bloc.close();

      expect(states, [
        const NewsLoadInProgress(),
        NewsLoadSuccess(await repository.fetchNews()),
      ]);
    });

    test('emits loading and then a failure when the repository fails', () async {
      final bloc = NewsBloc(repository: _FailingNewsRepository());
      final states = <NewsState>[];
      bloc.stream.listen(states.add);

      bloc.add(const NewsStarted());
      await bloc.close();

      expect(states, [
        const NewsLoadInProgress(),
        isA<NewsLoadFailure>().having(
          (state) => state.error,
          'error',
          isException,
        ),
      ]);
    });
  });
}
