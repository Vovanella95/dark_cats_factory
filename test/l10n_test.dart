import 'package:blocks/blocks.dart';
import 'package:dark_cats_factory/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every supported locale provides every message', () {
    expect(appSupportedLocales.map((locale) => locale.languageCode), [
      'en',
      'ru',
      'es',
    ]);

    for (final locale in appSupportedLocales) {
      final l10n = lookupAppLocalizations(locale);
      final messages = [
        l10n.appTitle,
        l10n.startButton,
        l10n.homeTitle,
        l10n.exploreTitle,
        l10n.collectionTitle,
        l10n.profileTitle,
        l10n.failedToLoadCats,
        l10n.deleteButton,
        l10n.shareButton,
        l10n.settingsTitle,
        l10n.languageSetting,
        l10n.switchLanguageButton,
        l10n.systemLanguage,
      ];
      for (final message in messages) {
        expect(
          message,
          isNotEmpty,
          reason: '${locale.languageCode}: message must be translated',
        );
      }
    }
  });

  test('Russian and Spanish provide real translations', () {
    final ru = lookupAppLocalizations(const Locale('ru'));
    final es = lookupAppLocalizations(const Locale('es'));

    expect(ru.startButton, 'Начать');
    expect(ru.profileTitle, 'Профиль');
    expect(ru.failedToLoadCats, 'Не удалось загрузить котов');
    expect(es.startButton, 'Empezar');
    expect(es.collectionTitle, 'Colección');
    expect(es.failedToLoadCats, 'No se pudieron cargar los gatos');
  });
}
