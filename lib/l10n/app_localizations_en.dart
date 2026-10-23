// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Dark Cats Factory';

  @override
  String get startButton => 'Start';

  @override
  String get homeTitle => 'Home';

  @override
  String get exploreTitle => 'Explore';

  @override
  String get collectionTitle => 'Collection';

  @override
  String get profileTitle => 'Profile';

  @override
  String get failedToLoadCats => 'Failed to load cats';

  @override
  String get deleteButton => 'Delete';

  @override
  String get shareButton => 'Share';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageSetting => 'Language';

  @override
  String get switchLanguageButton => 'Switch language';

  @override
  String get systemLanguage => 'System default';
}
