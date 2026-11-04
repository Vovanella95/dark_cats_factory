import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

/// Base class of all news states.
sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => const [];
}

/// Nothing has been requested yet.
final class NewsInitial extends NewsState {
  const NewsInitial();
}

/// The news feed is being fetched.
final class NewsLoadInProgress extends NewsState {
  const NewsLoadInProgress();
}

/// The news feed has been fetched successfully.
final class NewsLoadSuccess extends NewsState {
  const NewsLoadSuccess(this.news);

  /// The fetched news items, newest first.
  final List<NewsItem> news;

  @override
  List<Object?> get props => [news];
}

/// Fetching the news feed failed.
final class NewsLoadFailure extends NewsState {
  const NewsLoadFailure(this.error);

  /// The error that caused the failure.
  final Object error;

  @override
  List<Object?> get props => [error];
}
