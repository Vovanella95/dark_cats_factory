import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

/// Base class of all collection states.
sealed class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object?> get props => const [];
}

/// Nothing has been requested yet.
final class CollectionInitial extends CollectionState {
  const CollectionInitial();
}

/// The collection is being fetched.
final class CollectionLoadInProgress extends CollectionState {
  const CollectionLoadInProgress();
}

/// The collection has been fetched successfully.
final class CollectionLoadSuccess extends CollectionState {
  const CollectionLoadSuccess(this.cats);

  /// The fetched cats, in display order.
  final List<Cat> cats;

  @override
  List<Object?> get props => [cats];
}

/// Fetching the collection failed.
final class CollectionLoadFailure extends CollectionState {
  const CollectionLoadFailure(this.error);

  /// The error that caused the failure.
  final Object error;

  @override
  List<Object?> get props => [error];
}
