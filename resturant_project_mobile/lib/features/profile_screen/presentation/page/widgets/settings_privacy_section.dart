import 'package:flutter/material.dart';

import 'settings_section_card.dart';
import 'settings_tile.dart';
import 'settings_togle_tile.dart';

class SettingsPrivacySection extends StatelessWidget {
  const SettingsPrivacySection({
    super.key,
    required this.locationEnabled,
    required this.onLocationChanged,
    required this.onPrivacyPolicy,
    required this.onTermsOfService,
  });

  final bool locationEnabled;
  final ValueChanged<bool> onLocationChanged;
  final VoidCallback onPrivacyPolicy;
  final VoidCallback onTermsOfService;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'Privacy & Security',
      child: Column(
        children: [
          SettingsToggleTile(
            icon: Icons.location_on_outlined,
            title: 'Location Access',
            subtitle: 'Used to find nearby restaurants',
            value: locationEnabled,
            onChanged: onLocationChanged,
          ),
          SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'How we handle your data',
            onTap: onPrivacyPolicy,
          ),
          SettingsTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            subtitle: 'Our usage terms and conditions',
            onTap: onTermsOfService,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
