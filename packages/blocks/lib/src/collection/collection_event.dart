import 'package:equatable/equatable.dart';

/// Base class of all collection events.
sealed class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object?> get props => const [];
}

/// Signals that the collection should be loaded.
final class CollectionStarted extends CollectionEvent {
  const CollectionStarted();
}
