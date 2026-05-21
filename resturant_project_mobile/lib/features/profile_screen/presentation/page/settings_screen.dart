import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/profile_screen/data/repository/settings_repo.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/settings_cubit.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/settings_state.dart';
import 'widgets/settings_account_section.dart';
import 'widgets/settings_appearance_section.dart';
import 'widgets/settings_logout_button.dart';
import 'widgets/settings_logout_dialog.dart';
import 'widgets/settings_notifications_section.dart';
import 'widgets/settings_privacy_section.dart';
import 'widgets/settings_support_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Notification toggles
  bool pushNotificationsEnabled = true;
  bool emailNotificationsEnabled = true;
  bool promotionsEnabled = true;

  // Appearance toggles
  bool darkModeEnabled = false;
  String currentLanguage = 'English';

  // Privacy toggles
  bool locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        repo: SettingsRepo(api: DioConsumer(dio: Dio())),
      ),
      child: _SettingsView(
        pushNotificationsEnabled: pushNotificationsEnabled,
        emailNotificationsEnabled: emailNotificationsEnabled,
        promotionsEnabled: promotionsEnabled,
        darkModeEnabled: darkModeEnabled,
        currentLanguage: currentLanguage,
        locationEnabled: locationEnabled,
        onPushNotificationsChanged: (value) {
          setState(() => pushNotificationsEnabled = value);
        },
        onEmailNotificationsChanged: (value) {
          setState(() => emailNotificationsEnabled = value);
        },
        onPromotionsChanged: (value) {
          setState(() => promotionsEnabled = value);
        },
        onDarkModeChanged: (value) {
          setState(() => darkModeEnabled = value);
        },
        onLanguageTap: _showLanguageOptions,
        onLocationChanged: (value) {
          setState(() => locationEnabled = value);
        },
      ),
    );
  }

  void _showLanguageOptions() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Select Language',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: AppColors.primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English', dialogContext),
            _buildLanguageOption('العربية', dialogContext),
            _buildLanguageOption('Français', dialogContext),
            _buildLanguageOption('Español', dialogContext),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, BuildContext context) {
    return ListTile(
      title: Text(language),
      trailing: currentLanguage == language
          ? Icon(Icons.check, color: AppColors.primaryColor)
          : null,
      onTap: () {
        setState(() => currentLanguage = language);
        Navigator.pop(context);
      },
    );
  }
}

class _SettingsView extends StatelessWidget {
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool promotionsEnabled;
  final bool darkModeEnabled;
  final String currentLanguage;
  final bool locationEnabled;
  final ValueChanged<bool> onPushNotificationsChanged;
  final ValueChanged<bool> onEmailNotificationsChanged;
  final ValueChanged<bool> onPromotionsChanged;
  final ValueChanged<bool> onDarkModeChanged;
  final VoidCallback onLanguageTap;
  final ValueChanged<bool> onLocationChanged;

  const _SettingsView({
    required this.pushNotificationsEnabled,
    required this.emailNotificationsEnabled,
    required this.promotionsEnabled,
    required this.darkModeEnabled,
    required this.currentLanguage,
    required this.locationEnabled,
    required this.onPushNotificationsChanged,
    required this.onEmailNotificationsChanged,
    required this.onPromotionsChanged,
    required this.onDarkModeChanged,
    required this.onLanguageTap,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.snackBarSuccessColor,
              duration: const Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            context.goNamed(RouteName.authRouteScreen);
          });
        }

        if (state is DeleteAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.snackBarErrorColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeightSpace(height: 24),

              // Account Settings Section
              SettingsAccountSection(
                onEditProfile: () {
                  context.goNamed(RouteName.editProfileScreen);
                },
                onChangePassword: () {
                  context.goNamed(RouteName.editProfileScreen);
                },
                onDeleteAccount: () {
                  _showDeleteAccountDialog(context);
                },
              ),

              HeightSpace(height: 20),

              // Notifications Section
              SettingsNotificationsSection(
                pushEnabled: pushNotificationsEnabled,
                emailEnabled: emailNotificationsEnabled,
                promoEnabled: promotionsEnabled,
                onPushChanged: onPushNotificationsChanged,
                onEmailChanged: onEmailNotificationsChanged,
                onPromoChanged: onPromotionsChanged,
              ),

              HeightSpace(height: 20),

              // Appearance Section
              SettingsAppearanceSection(
                darkModeEnabled: darkModeEnabled,
                onDarkModeChanged: onDarkModeChanged,
                currentLanguage: currentLanguage,
                onLanguageTap: onLanguageTap,
              ),

              HeightSpace(height: 20),

              // Privacy & Security Section
              SettingsPrivacySection(
                locationEnabled: locationEnabled,
                onLocationChanged: onLocationChanged,
                onPrivacyPolicy: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening Privacy Policy...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                onTermsOfService: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening Terms of Service...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),

              HeightSpace(height: 20),

              // Support Section
              SettingsSupportSection(
                onHelpCenter: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening Help Center...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                onContactUs: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening Contact Us...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                onRateApp: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening App Store...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),

              HeightSpace(height: 20),

              // Logout Button
              SettingsLogoutButton(
                onTap: () {
                  SettingsLogoutDialog.show(
                    context,
                    onConfirm: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged out successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        context.goNamed(RouteName.authRouteScreen);
                      });
                    },
                  );
                },
              ),

              HeightSpace(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Delete Account',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.red,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 48.sp),
            HeightSpace(height: 16),
            Text(
              'Are you sure you want to delete your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            HeightSpace(height: 12),
            Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'This action cannot be undone. All your data including reviews, favorites, and profile information will be permanently deleted.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Colors.red.shade800,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.grayColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              cubit.deleteAccount();
              Navigator.pop(dialogContext);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
