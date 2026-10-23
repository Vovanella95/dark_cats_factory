import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Placeholder content of the shell's explore destination.
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocalizations.of(context).exploreTitle)),
    );
  }
}
