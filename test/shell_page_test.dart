import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dark_cats_factory/pages/collection_page.dart';
import 'package:dark_cats_factory/pages/explore_page.dart';
import 'package:dark_cats_factory/pages/home_page.dart';
import 'package:dark_cats_factory/pages/settings_page.dart';
import 'package:dark_cats_factory/pages/shell_page.dart';

void main() {
  Future<void> pumpShell(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ShellPage()));
    await tester.pumpAndSettle();
  }

  Future<void> tapDestination(WidgetTester tester, String label) async {
    await tester.tap(find.text(label).last);
    await tester.pumpAndSettle();
  }

  testWidgets('shell offers the four destinations', (tester) async {
    await pumpShell(tester);

    final navigationBar = find.byType(NavigationBar);
    expect(navigationBar, findsOneWidget);
    expect(
      find.descendant(of: navigationBar, matching: find.text('Home')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: navigationBar, matching: find.text('Explore')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: navigationBar, matching: find.text('Collection')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: navigationBar, matching: find.text('Profile')),
      findsOneWidget,
    );
  });

  testWidgets('home is the initial destination', (tester) async {
    await pumpShell(tester);

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(ExplorePage), findsNothing);
    expect(find.byType(CollectionPage), findsNothing);
    expect(find.byType(SettingsPage), findsNothing);
  });

  testWidgets('explore destination shows the explore page', (tester) async {
    await pumpShell(tester);

    await tapDestination(tester, 'Explore');

    expect(find.byType(ExplorePage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
  });

  testWidgets('collection destination shows the collection page', (
    tester,
  ) async {
    await pumpShell(tester);

    await tapDestination(tester, 'Collection');

    expect(find.byType(CollectionPage), findsOneWidget);
  });

  testWidgets('profile destination shows the settings page', (tester) async {
    await pumpShell(tester);

    await tapDestination(tester, 'Profile');

    expect(find.byType(SettingsPage), findsOneWidget);
  });

  testWidgets('visited destinations stay alive while switching tabs', (
    tester,
  ) async {
    await pumpShell(tester);

    await tapDestination(tester, 'Explore');
    await tapDestination(tester, 'Collection');

    // IndexedStack keeps every visited page mounted, just offstage.
    expect(find.byType(HomePage, skipOffstage: false), findsOneWidget);
    expect(find.byType(ExplorePage, skipOffstage: false), findsOneWidget);
    expect(find.byType(CollectionPage, skipOffstage: false), findsOneWidget);
    // Exactly one destination is visible at a time.
    expect(find.byType(CollectionPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
  });
}
