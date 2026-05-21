import 'package:flutter/material.dart';

import 'settings_section_card.dart';
import 'settings_tile.dart';
import 'settings_togle_tile.dart';

class SettingsAppearanceSection extends StatelessWidget {
  const SettingsAppearanceSection({
    super.key,
    required this.darkModeEnabled,
    required this.onDarkModeChanged,
    required this.currentLanguage,
    required this.onLanguageTap,
  });

  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;
  final String currentLanguage;
  final VoidCallback onLanguageTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'Appearance',
      child: Column(
        children: [
          SettingsToggleTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Switch to a darker colour scheme',
            value: darkModeEnabled,
            onChanged: onDarkModeChanged,
          ),
          SettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: currentLanguage,
            onTap: onLanguageTap,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
