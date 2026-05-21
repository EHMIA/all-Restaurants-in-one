import 'package:flutter/material.dart';

import 'settings_section_card.dart';
import 'settings_tile.dart';

class SettingsSupportSection extends StatelessWidget {
  const SettingsSupportSection({
    super.key,
    required this.onHelpCenter,
    required this.onContactUs,
    required this.onRateApp,
  });

  final VoidCallback onHelpCenter;
  final VoidCallback onContactUs;
  final VoidCallback onRateApp;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'Support',
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'Browse FAQs and guides',
            onTap: onHelpCenter,
          ),
          SettingsTile(
            icon: Icons.headset_mic_outlined,
            title: 'Contact Us',
            subtitle: 'Reach our support team',
            onTap: onContactUs,
          ),
          SettingsTile(
            icon: Icons.star_outline,
            title: 'Rate the App',
            subtitle: 'Tell us what you think',
            onTap: onRateApp,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
