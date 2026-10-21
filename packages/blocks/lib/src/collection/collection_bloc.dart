import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import 'collection_event.dart';
import 'collection_state.dart';

/// Loads and exposes the collection of cats.
final class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  /// Creates a bloc that fetches cats through [repository].
  CollectionBloc({required CatsRepository repository})
    : _repository = repository,
      super(const CollectionInitial()) {
    on<CollectionStarted>(_onStarted);
  }

  final CatsRepository _repository;

  Future<void> _onStarted(
    CollectionStarted event,
    Emitter<CollectionState> emit,
  ) async {
    emit(const CollectionLoadInProgress());
    try {
      emit(CollectionLoadSuccess(await _repository.fetchCats()));
    } on Object catch (error) {
      emit(CollectionLoadFailure(error));
    }
  }
}
