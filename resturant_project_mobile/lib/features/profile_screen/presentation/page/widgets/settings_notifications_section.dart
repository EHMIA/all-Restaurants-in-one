import 'package:flutter/material.dart';

import 'settings_section_card.dart';
import 'settings_togle_tile.dart';

class SettingsNotificationsSection extends StatelessWidget {
  const SettingsNotificationsSection({
    super.key,
    required this.pushEnabled,
    required this.emailEnabled,
    required this.promoEnabled,
    required this.onPushChanged,
    required this.onEmailChanged,
    required this.onPromoChanged,
  });

  final bool pushEnabled;
  final bool emailEnabled;
  final bool promoEnabled;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onEmailChanged;
  final ValueChanged<bool> onPromoChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'Notifications',
      child: Column(
        children: [
          SettingsToggleTile(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            subtitle: 'Receive order updates in real time',
            value: pushEnabled,
            onChanged: onPushChanged,
          ),
          SettingsToggleTile(
            icon: Icons.email_outlined,
            title: 'Email Notifications',
            subtitle: 'Get receipts and updates via email',
            value: emailEnabled,
            onChanged: onEmailChanged,
          ),
          SettingsToggleTile(
            icon: Icons.local_offer_outlined,
            title: 'Promotions & Deals',
            subtitle: 'Be the first to know about offers',
            value: promoEnabled,
            onChanged: onPromoChanged,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
