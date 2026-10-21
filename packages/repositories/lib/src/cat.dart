import 'package:equatable/equatable.dart';

/// A cat offered by the factory.
final class Cat extends Equatable {
  const Cat({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
  }) : assert(
         rating >= 1 && rating <= 5,
         'rating must be between 1 and 5 stars',
       );

  /// Unique identifier of the cat.
  final String id;

  /// Display name of the cat.
  final String name;

  /// Path or URL of the cat's image.
  final String imageUrl;

  /// Star rating of the cat, from 1 to 5.
  final int rating;

  @override
  List<Object?> get props => [id, name, imageUrl, rating];
}
