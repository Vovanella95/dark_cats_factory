import 'package:blocks/blocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../widgets/news_card.dart';

/// News feed of the shell's home destination.
///
/// Creates its own bloc and starts loading right away; the repository can
/// be injected for tests.
class HomePage extends StatelessWidget {
  const HomePage({super.key, this.repository});

  /// Repository used to fetch the news; defaults to the fake one.
  final NewsRepository? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NewsBloc(repository: repository ?? const FakeNewsRepository())
            ..add(const NewsStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) => switch (state) {
          NewsLoadSuccess(:final news) => ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: news.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) => NewsCard(item: news[index]),
          ),
          NewsLoadFailure() => const _HomeError(),
          NewsInitial() || NewsLoadInProgress() => const Center(
            child: CircularProgressIndicator(),
          ),
        },
      ),
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError();

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
          const Text('Failed to load news'),
        ],
      ),
    );
  }
}
