import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import 'star_rating.dart';

/// Card of the collection grid showing a cat's image, name and rating.
class CatCard extends StatelessWidget {
  const CatCard({super.key, required this.cat});

  /// The cat displayed by this card.
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Image.asset(cat.imageUrl, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  cat.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                StarRating(rating: cat.rating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
