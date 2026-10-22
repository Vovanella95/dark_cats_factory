import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../routing/app_routes.dart';

/// Placeholder content of the shell's profile destination.
///
/// Exposes the application settings through the app bar action.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settingsTitle,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: Center(child: Text(l10n.profileTitle)),
    );
  }
}
