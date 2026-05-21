import 'package:flutter/material.dart';

import 'settings_info_tile.dart';
import 'settings_section_card.dart';
import 'settings_tile.dart';

class SettingsAboutSection extends StatelessWidget {
  const SettingsAboutSection({
    super.key,
    required this.appVersion,
    required this.onLicenses,
  });

  final String appVersion;
  final VoidCallback onLicenses;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'About',
      child: Column(
        children: [
          SettingsInfoTile(
            icon: Icons.info_outline,
            title: 'App Version',
            value: appVersion,
          ),
          SettingsTile(
            icon: Icons.article_outlined,
            title: 'Open-Source Licenses',
            onTap: onLicenses,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
