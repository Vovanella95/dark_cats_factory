import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Placeholder content of the shell's home destination.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(AppLocalizations.of(context).homeTitle)),
    );
  }
}
