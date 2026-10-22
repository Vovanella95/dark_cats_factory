// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Dark Cats Factory';

  @override
  String get startButton => 'Начать';

  @override
  String get homeTitle => 'Главная';

  @override
  String get exploreTitle => 'Обзор';

  @override
  String get collectionTitle => 'Коллекция';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get failedToLoadCats => 'Не удалось загрузить котов';

  @override
  String get deleteButton => 'Удалить';

  @override
  String get shareButton => 'Поделиться';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get languageSetting => 'Язык';

  @override
  String get switchLanguageButton => 'Сменить язык';

  @override
  String get systemLanguage => 'Системный';
}
