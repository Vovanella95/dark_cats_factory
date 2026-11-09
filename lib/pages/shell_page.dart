import 'package:flutter/material.dart';

import 'collection_page.dart';
import 'explore_page.dart';
import 'home_page.dart';
import 'settings_page.dart';

/// The destinations offered by the [ShellPage], in display order.
enum ShellDestination { home, explore, collection, profile }

/// Top-level container hosting the four main destinations.
///
/// The destination is switched through a [NavigationBar] and kept in an
/// [IndexedStack], so the state of every destination survives tab changes.
class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  ShellDestination _destination = ShellDestination.home;

  static const Map<ShellDestination, Widget> _pages = {
    ShellDestination.home: HomePage(),
    ShellDestination.explore: ExplorePage(),
    ShellDestination.collection: CollectionPage(),
    ShellDestination.profile: SettingsPage(),
  };

  static const Map<ShellDestination, (IconData, IconData)> _icons = {
    ShellDestination.home: (Icons.home_outlined, Icons.home),
    ShellDestination.explore: (Icons.explore_outlined, Icons.explore),
    ShellDestination.collection: (
      Icons.collections_bookmark_outlined,
      Icons.collections_bookmark,
    ),
    ShellDestination.profile: (Icons.person_outline, Icons.person),
  };

  void _onDestinationSelected(int index) {
    setState(() => _destination = ShellDestination.values[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _destination.index,
        children: _pages.values.toList(growable: false),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _destination.index,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          for (final destination in ShellDestination.values)
            NavigationDestination(
              icon: Icon(_icons[destination]!.$1),
              selectedIcon: Icon(_icons[destination]!.$2),
              label: destination.name.capitalize,
            ),
        ],
      ),
    );
  }
}

extension on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
