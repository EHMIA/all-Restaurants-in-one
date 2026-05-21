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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        repo: SettingsRepo(api: DioConsumer(dio: Dio())),
      ),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

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

              // Account Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        HeightSpace(height: 16),
                        Divider(
                          color: Colors.grey.shade200,
                          thickness: 0.5,
                          height: 1,
                        ),
                        HeightSpace(height: 16),

                        // Delete Account Section
                        GestureDetector(
                          onTap: () => _showDeleteAccountDialog(context),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                                size: 24.sp,
                              ),
                              WidthSpace(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delete Account',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                  HeightSpace(height: 4),
                                  Text(
                                    'Permanently delete your account',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.red,
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
