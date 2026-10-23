import 'package:dark_cats_factory/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const menuLabels = [
    'Edit profile',
    'Purchases',
    'Notifications',
    'Appearance',
    'Help & support',
    'Settings',
  ];

  Future<void> pumpSettings(
    WidgetTester tester, {
    ValueChanged<SettingsMenu>? onItemSelected,
  }) async {
    await tester.pumpWidget(
      MaterialApp(home: SettingsPage(onItemSelected: onItemSelected)),
    );
    await tester.pumpAndSettle();
  }

  List<ListTile> menuTiles(WidgetTester tester) =>
      tester
          .widgetList<ListTile>(find.byType(ListTile))
          .toList(growable: false);

  testWidgets('screen is titled settings', (tester) async {
    await pumpSettings(tester);

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.descendant(of: find.byType(AppBar), matching: find.text('Settings')), findsOneWidget);
  });

  testWidgets('shows the profile info above the menu', (tester) async {
    await pumpSettings(tester);

    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('Alex Meower'), findsOneWidget);
    expect(find.text('alex.meower@darkcats.factory'), findsOneWidget);

    final avatarTop = tester.getTopLeft(find.byType(CircleAvatar)).dy;
    final firstMenuItemTop = tester.getTopLeft(find.text(menuLabels.first)).dy;
    expect(avatarTop, lessThan(firstMenuItemTop));
  });

  testWidgets('shows a menu button for every settings entry', (tester) async {
    await pumpSettings(tester);

    final tiles = menuTiles(tester);
    expect(tiles, hasLength(menuLabels.length));
    for (final label in menuLabels) {
      expect(
        find.descendant(of: find.byType(ListTile), matching: find.text(label)),
        findsOneWidget,
      );
    }
  });

  testWidgets('menu entries appear in order and are tappable', (tester) async {
    await pumpSettings(tester);

    final tiles = menuTiles(tester);
    expect(
      tiles.map((tile) => (tile.title as Text).data),
      orderedEquals(menuLabels),
    );
    expect(
      tiles.every((tile) => tile.onTap != null),
      isTrue,
      reason: 'every menu entry must be a button',
    );
    expect(
      tiles.every((tile) => tile.leading is Icon),
      isTrue,
      reason: 'every menu entry must have an icon',
    );
  });

  testWidgets('tapping a menu entry reports it', (tester) async {
    final selected = <SettingsMenu>[];
    await pumpSettings(tester, onItemSelected: selected.add);

    for (final (index, label) in menuLabels.indexed) {
      final tile = find.byType(ListTile).at(index);
      await tester.ensureVisible(tile);
      await tester.tap(tile);
      await tester.pumpAndSettle();

      expect(selected, hasLength(index + 1));
      expect(selected.last, SettingsMenu.values[index]);
      expect(
        find.descendant(of: tile, matching: find.text(label)),
        findsOneWidget,
      );
    }
  });
}
