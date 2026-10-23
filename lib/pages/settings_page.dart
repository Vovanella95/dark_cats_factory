import 'package:blocks/blocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../l10n/app_localizations.dart';

/// User preferences; currently only the application language.
///
/// The language is switched through the [LocaleCubit] provided above the
/// [MaterialApp], so tapping the button rebuilds the whole application in
/// the next localization.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleCubit>().state;
    // Autonyms of the supported locales; shown unchanged in every language.
    final languageName = switch (locale) {
      const Locale('en') => 'English',
      const Locale('ru') => 'Руский',
      const Locale('es') => 'Español',
      _ => l10n.systemLanguage,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.languageSetting),
            subtitle: Text(languageName),
            trailing: FilledButton.tonal(
              onPressed: () => context.read<LocaleCubit>().toggle(),
              child: Text(l10n.switchLanguageButton),
            ),
          ),
        ],
      ),
    );
  }
}
