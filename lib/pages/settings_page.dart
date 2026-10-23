import 'package:flutter/material.dart';

/// Entries of the settings menu, in display order.
enum SettingsMenu {
  editProfile(Icons.person_outline, 'Edit profile'),
  purchases(Icons.shopping_bag_outlined, 'Purchases'),
  notifications(Icons.notifications_outlined, 'Notifications'),
  appearance(Icons.palette_outlined, 'Appearance'),
  help(Icons.help_outline, 'Help & support'),
  settings(Icons.settings_outlined, 'Settings');

  const SettingsMenu(this.icon, this.label);

  /// Icon shown in front of the menu entry.
  final IconData icon;

  /// Text of the menu entry.
  final String label;
}

/// Settings screen: profile info at the top and a menu of entries below.
///
/// The screen is purely presentational; menu selections are delegated
/// through [onItemSelected] and the profile details are placeholders until
/// a profile source exists.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, this.onItemSelected});

  /// Called when the user taps a menu entry.
  final ValueChanged<SettingsMenu>? onItemSelected;

  static const String _profileName = 'Alex Meower';
  static const String _profileEmail = 'alex.meower@darkcats.factory';

  void _select(SettingsMenu item) => onItemSelected?.call(item);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 48,
                  child: Icon(Icons.person, size: 48),
                ),
                const SizedBox(height: 16),
                Text(_profileName, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(
                  _profileEmail,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          for (final item in SettingsMenu.values)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _select(item),
            ),
        ],
      ),
    );
  }
}
