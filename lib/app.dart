import 'package:blocks/blocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'l10n/app_localizations.dart';
import 'pages/settings_page.dart';
import 'pages/shell_page.dart';
import 'pages/start_page.dart';
import 'routing/app_routes.dart';

/// Root widget wiring the application's named routes and its locale.
///
/// The [LocaleCubit] lives above the [MaterialApp]: toggling the locale
/// rebuilds the whole application in the selected localization, while
/// `null` follows the system locale.
class DarkCatsFactoryApp extends StatelessWidget {
  const DarkCatsFactoryApp({super.key, this.initialRoute});

  /// Overrides the route the app opens with; used by tests.
  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocaleCubit(),
      child: BlocBuilder<LocaleCubit, Locale?>(
        builder: (context, locale) {
          return MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: appSupportedLocales,
            initialRoute: initialRoute,
            routes: {
              AppRoutes.start: (context) => const StartPage(),
              AppRoutes.shell: (context) => const ShellPage(),
              AppRoutes.settings: (context) => const SettingsPage(),
            },
          );
        },
      ),
    );
  }
}
