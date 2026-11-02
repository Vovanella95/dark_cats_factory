import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import 'news_event.dart';
import 'news_state.dart';

/// Loads and exposes the news feed of the home screen.
final class NewsBloc extends Bloc<NewsEvent, NewsState> {
  /// Creates a bloc that fetches news through [repository].
  NewsBloc({required this._repository}) : super(const NewsInitial()) {
    on<NewsStarted>(_onStarted);
  }

  final NewsRepository _repository;

  Future<void> _onStarted(
    NewsStarted event,
    Emitter<NewsState> emit,
  ) async {
    emit(const NewsLoadInProgress());
    try {
      emit(NewsLoadSuccess(await _repository.fetchNews()));
    } on Object catch (error) {
      emit(NewsLoadFailure(error));
    }
  }
}
