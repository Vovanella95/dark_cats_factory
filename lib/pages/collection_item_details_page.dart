import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../l10n/app_localizations.dart';
import '../widgets/star_rating.dart';

/// Full-screen details of a single collection item.
///
/// Shows the cat's image, name, rating and additional description, with
/// the "Delete" and "Share" actions fixed at the bottom of the page. The
/// actions are delegated through [onDelete] and [onShare]; the page itself
/// performs no removal or sharing.
class CollectionItemDetailsPage extends StatelessWidget {
  const CollectionItemDetailsPage({
    super.key,
    required this.cat,
    this.onDelete,
    this.onShare,
  });

  /// The cat displayed by this page.
  final Cat cat;

  /// Called when the user taps "Delete".
  final VoidCallback? onDelete;

  /// Called when the user taps "Share".
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Image.asset(cat.imageUrl, fit: BoxFit.cover)),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cat.name, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  StarRating(rating: cat.rating),
                  const SizedBox(height: 16),
                  Text(cat.description, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: onDelete,
                  style: FilledButton.styleFrom(
                    foregroundColor: colorScheme.error,
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.deleteButton),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onShare,
                  icon: const Icon(Icons.share),
                  label: Text(l10n.shareButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
