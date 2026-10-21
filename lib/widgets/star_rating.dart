import 'package:flutter/material.dart';

/// Row of [total] stars with exactly [rating] of them filled.
class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, this.total = 5});

  /// Number of filled stars, from 1 to [total].
  final int rating;

  /// Total number of stars in the row.
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= total; i++)
          Icon(
            i <= rating ? Icons.star : Icons.star_border,
            size: 16,
            color: Colors.amber,
          ),
      ],
    );
  }
}
