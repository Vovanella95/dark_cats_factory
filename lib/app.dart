import 'package:flutter/material.dart';

import 'pages/shell_page.dart';
import 'pages/start_page.dart';
import 'routing/app_routes.dart';

/// Root widget wiring the application's named routes.
class DarkCatsFactoryApp extends StatelessWidget {
  const DarkCatsFactoryApp({super.key, this.initialRoute});

  /// Overrides the route the app opens with; used by tests.
  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Cats Factory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: initialRoute,
      routes: {
        AppRoutes.start: (context) => const StartPage(),
        AppRoutes.shell: (context) => const ShellPage(),
      },
    );
  }
}
