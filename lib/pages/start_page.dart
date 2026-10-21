import 'package:flutter/material.dart';

import '../routing/app_routes.dart';

/// First screen shown when the application launches.
///
/// The only responsibility is to introduce the app and lead the user into
/// the [ShellPage] through the [AppRoutes.shell] route.
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dark Cats Factory',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.shell),
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
