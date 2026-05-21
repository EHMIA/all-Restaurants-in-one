import 'package:flutter/material.dart';

import 'settings_section_card.dart';
import 'settings_tile.dart';

class SettingsAccountSection extends StatelessWidget {
  const SettingsAccountSection({
    super.key,
    required this.onEditProfile,
    required this.onChangePassword,
    required this.onDeleteAccount,
  });

  final VoidCallback onEditProfile;
  final VoidCallback onChangePassword;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'Account Settings',
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your personal information',
            onTap: onEditProfile,
          ),
          SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Manage your account password',
            onTap: onChangePassword,
          ),
          SettingsTile(
            icon: Icons.delete_forever_outlined,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account',
            onTap: onDeleteAccount,
            isDestructive: true,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
