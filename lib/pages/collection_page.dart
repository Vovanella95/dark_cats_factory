import 'package:blocks/blocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../widgets/cat_card.dart';
import 'collection_item_details_page.dart';

/// Grid of cat cards backed by the [CollectionBloc].
///
/// Creates its own bloc and starts loading right away; the repository can be
/// injected for tests.
class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key, this.repository});

  /// Repository used to fetch the cats; defaults to the fake one.
  final CatsRepository? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CollectionBloc(repository: repository ?? const FakeCatsRepository())
            ..add(const CollectionStarted()),
      child: const _CollectionView(),
    );
  }
}

class _CollectionView extends StatelessWidget {
  const _CollectionView();

  void _openDetails(BuildContext context, Cat cat) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CollectionItemDetailsPage(cat: cat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collection')),
      body: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) => switch (state) {
          CollectionLoadSuccess(:final cats) => GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: cats.length,
            itemBuilder: (context, index) {
              final cat = cats[index];
              return CatCard(cat: cat, onTap: () => _openDetails(context, cat));
            },
          ),
          CollectionLoadFailure() => const _CollectionError(),
          CollectionInitial() || CollectionLoadInProgress() => const Center(
            child: CircularProgressIndicator(),
          ),
        },
      ),
    );
  }
}

class _CollectionError extends StatelessWidget {
  const _CollectionError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 8),
          const Text('Failed to load cats'),
        ],
      ),
    );
  }
}
