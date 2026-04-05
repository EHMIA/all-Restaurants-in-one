import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. ضيف الـ import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_password_requirements_reset_password.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

import '../bloc/reset_password_bloc.dart';
import '../bloc/reset_password_event.dart';
import '../bloc/reset_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';
    if (value.length < 8) return 'Must be at least 8 characters';
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Must contain an uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) return 'Must contain a number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xffFFF8F0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              context.goNamed(RouteName.authRouteScreen);
            } else if (state is ResetPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(24.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5.r,
                          blurRadius: 15.r,
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeightSpace(height: 20),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 70.w,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: SvgPicture.asset(AppAssets.logo),
                                ),
                                const HeightSpace(height: 16),
                                Text(
                                  "Akiel",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const HeightSpace(height: 24),
                                Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const HeightSpace(height: 16),
                                Text(
                                  "Create a strong new password for your account.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xff64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const HeightSpace(height: 40),

                          // New Password Field
                          CustomTextField(
                            controller: _newPasswordController,
                            validator: _validatePassword,
                            textFieldTitle: "New Password",
                            hintText: "Enter new password",
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: const Color(0xff94A3B8),
                              size: 25.sp,
                            ),
                          ),

                          CustomPasswordRequirementsResetPassword(),

                          // Confirm Password Field
                          CustomTextField(
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            textFieldTitle: "Confirm Password",
                            hintText: "Confirm your password",
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: const Color(0xff94A3B8),
                              size: 25.sp,
                            ),
                          ),

                          const HeightSpace(height: 32),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is ResetPasswordLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<ResetPasswordBloc>().add(
                                          ResetPasswordSubmitted(
                                            newPassword:
                                                _newPasswordController.text,
                                            confirmPassword:
                                                _confirmPasswordController.text,
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: state is ResetPasswordLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Reset Password",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const HeightSpace(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () =>
                                  context.goNamed(RouteName.authRouteScreen),
                              child: Text(
                                "Back to Login",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const HeightSpace(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
