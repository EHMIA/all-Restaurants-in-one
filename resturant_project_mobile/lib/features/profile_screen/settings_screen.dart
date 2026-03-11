import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool twoFactorAuth = false;
  String selectedLanguage = 'English';
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ACCOUNT SETTINGS SECTION
            _buildSection(
              title: 'Account Settings',
              children: [
                _buildSettingsTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Update your name, email, phone number',
                  onTap: () => print('Edit Profile'),
                ),
                _buildSettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  subtitle: 'Update your security password',
                  onTap: () => print('Change Password'),
                ),
                _buildSettingsTile(
                  icon: Icons.email_outlined,
                  title: 'Email Address',
                  subtitle: 'akiel.mohammed@example.com',
                  onTap: () => print('Email Address'),
                ),
              ],
            ),

            /// NOTIFICATION SETTINGS SECTION
            _buildSection(
              title: 'Notifications',
              children: [
                _buildNotificationTile(
                  icon: Icons.mail_outline,
                  title: 'Email Notifications',
                  subtitle: 'Receive updates via email',
                  value: emailNotifications,
                  onChanged: (val) => setState(() => emailNotifications = val),
                ),
                _buildNotificationTile(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Receive in-app notifications',
                  value: pushNotifications,
                  onChanged: (val) => setState(() => pushNotifications = val),
                ),
                _buildNotificationTile(
                  icon: Icons.sms_outlined,
                  title: 'SMS Notifications',
                  subtitle: 'Receive SMS alerts',
                  value: smsNotifications,
                  onChanged: (val) => setState(() => smsNotifications = val),
                ),
              ],
            ),

            /// PRIVACY & SECURITY SECTION
            _buildSection(
              title: 'Privacy & Security',
              children: [
                _buildSettingsTile(
                  icon: Icons.shield_outlined,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Add extra layer of security',
                  onTap: () => _showTwoFactorDialog(),
                ),
                _buildSettingsTile(
                  icon: Icons.visibility_outlined,
                  title: 'Profile Visibility',
                  subtitle: 'Control who can see your profile',
                  onTap: () => print('Profile Visibility'),
                ),
                _buildSettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () => print('Privacy Policy'),
                ),
                _buildSettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  subtitle: 'Read our terms and conditions',
                  onTap: () => print('Terms & Conditions'),
                ),
              ],
            ),

            /// PREFERENCES SECTION
            _buildSection(
              title: 'Preferences',
              children: [
                _buildDropdownTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  value: selectedLanguage,
                  items: ['English', 'Español', 'Français', 'Deutsch'],
                  onChanged: (val) =>
                      setState(() => selectedLanguage = val ?? 'English'),
                ),
                _buildDropdownTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  value: selectedTheme,
                  items: ['Light', 'Dark', 'Auto'],
                  onChanged: (val) =>
                      setState(() => selectedTheme = val ?? 'Light'),
                ),
                _buildSettingsTile(
                  icon: Icons.location_on_outlined,
                  title: 'Default Location',
                  subtitle: 'Set your preferred restaurant location',
                  onTap: () => print('Default Location'),
                ),
              ],
            ),

            /// SUPPORT & HELP SECTION
            _buildSection(
              title: 'Support & Help',
              children: [
                _buildSettingsTile(
                  icon: Icons.help_outline,
                  title: 'FAQ',
                  subtitle: 'Frequently asked questions',
                  onTap: () => print('FAQ'),
                ),
                _buildSettingsTile(
                  icon: Icons.info_outline,
                  title: 'About App',
                  subtitle: 'Version 1.0.0 • Build 001',
                  onTap: () => print('About App'),
                ),
                _buildSettingsTile(
                  icon: Icons.mail_outline,
                  title: 'Contact Us',
                  subtitle: 'support@restaurantapp.com',
                  onTap: () => print('Contact Us'),
                ),
                _buildSettingsTile(
                  icon: Icons.bug_report_outlined,
                  title: 'Report Bug',
                  subtitle: 'Help us improve the app',
                  onTap: () => print('Report Bug'),
                ),
              ],
            ),

            /// DANGER ZONE SECTION
            _buildSection(
              title: 'Danger Zone',
              children: [
                _buildDangerTile(
                  icon: Icons.logout_outlined,
                  title: 'Logout',
                  subtitle: 'Sign out from your account',
                  onTap: () => _showLogoutDialog(context),
                  isDanger: false,
                ),
                _buildDangerTile(
                  icon: Icons.delete_forever_outlined,
                  title: 'Delete Account',
                  subtitle: 'Permanently delete your account and data',
                  onTap: () => _showDeleteAccountDialog(context),
                  isDanger: true,
                ),
              ],
            ),

            HeightSpace(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 12.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.grey[50],
          ),
          child: Column(children: children),
        ),
        HeightSpace(height: 8),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Icon(icon, color: AppColors.primaryColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Icon(icon, color: AppColors.primaryColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppColors.primaryColor, size: 24),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        trailing: DropdownButton<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          underline: SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildDangerTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDanger,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Icon(
        icon,
        color: isDanger ? Colors.red : AppColors.primaryColor,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: isDanger ? Colors.red : Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13.sp,
          color: isDanger ? Colors.red[300] : Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDanger ? Colors.red : Colors.grey,
      ),
      onTap: onTap,
    );
  }

  void _showTwoFactorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Two-Factor Authentication'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enable two-factor authentication for enhanced security.'),
            HeightSpace(height: 16),
            CheckboxListTile(
              title: Text('SMS Code'),
              value: false,
              onChanged: (val) {},
            ),
            CheckboxListTile(
              title: Text('Authenticator App'),
              value: false,
              onChanged: (val) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Two-Factor Authentication enabled')),
              );
            },
            child: Text('Enable', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout from your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logged out successfully')),
              );
              // TODO: Implement logout logic with navigation to login screen
              // GoRouter.of(context).go(RouteName.signInPage);
            },
            child: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Warning: This action cannot be undone!',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            HeightSpace(height: 12),
            Text('Deleting your account will permanently remove:'),
            HeightSpace(height: 8),
            Text('• Your profile and personal data'),
            Text('• All your reviews and ratings'),
            Text('• Your saved restaurants'),
            Text('• Your account history'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _showFinalDeleteConfirmation(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFinalDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Account Deletion'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Type your email address to confirm deletion:'),
            HeightSpace(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'your.email@example.com',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deleted successfully'),
                  backgroundColor: Colors.red,
                ),
              );
              // TODO: Implement account deletion with navigation to login screen
            },
            child: Text(
              'Delete Account',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
