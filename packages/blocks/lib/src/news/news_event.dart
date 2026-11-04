import 'package:equatable/equatable.dart';

/// Base class of all news events.
sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => const [];
}

/// Signals that the news feed should be loaded.
final class NewsStarted extends NewsEvent {
  const NewsStarted();
}
