import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return ''; // Valid
  }

  String? validatePasswordMatch(String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (_newPasswordController.text != confirmPassword) {
      return 'Passwords do not match';
    }
    return null; // Valid
  }

  void _handleResetPassword() {
    String newPassError = validatePassword(_newPasswordController.text);
    String? confirmPassError = validatePasswordMatch(
      _confirmPasswordController.text,
    );

    if (newPassError.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(newPassError), backgroundColor: Colors.red),
      );
      return;
    }

    if (confirmPassError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(confirmPassError), backgroundColor: Colors.red),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password reset successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to login after a short delay
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        GoRouter.of(context).goNamed(RouteName.authRouteScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      backgroundColor: Color(0xffFFF8F0),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header Section
                  const HeightSpace(height: 20),

                  /// Center content
                  Center(
                    child: Column(
                      children: [
                        /// Logo Icon
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

                        /// App Name
                        Text(
                          "Akiel",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: AppColors.primaryColor,
                          ),
                        ),

                        const HeightSpace(height: 24),

                        /// Title
                        Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: AppColors.primaryColor,
                          ),
                        ),

                        const HeightSpace(height: 16),

                        /// Description
                        SizedBox(
                          width: 280.w,
                          child: Text(
                            "Create a strong new password for your account.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: Color(0xff64748B),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const HeightSpace(height: 40),

                  /// New Password
                  CustomTextField(
                    controller: _newPasswordController,
                    validator: (value) {
                      String error = validatePassword(value ?? '');
                      return error.isEmpty ? null : error;
                    },
                    hintTextStyle: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff94A3B8),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff334155),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xff94A3B8),
                      size: 25.sp,
                    ),
                    fillColor: Color(0xffF8FAFC),
                    borderColor: Color(0xff94A3B8),
                    radius: 8,
                    textFieldTitle: "New Password",
                    hintText: "Enter new password",
                    isPassword: true,
                  ),

                  const HeightSpace(height: 20),

                  /// Password Requirements Info
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: Color(0xffFFF8F0),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Color(0xffFFEDD5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password Requirements:",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            color: Color(0xff64748B),
                          ),
                        ),
                        const HeightSpace(height: 8),
                        _buildRequirement("At least 8 characters"),
                        _buildRequirement("At least 1 uppercase letter (A-Z)"),
                        _buildRequirement("At least 1 lowercase letter (a-z)"),
                        _buildRequirement("At least 1 number (0-9)"),
                        _buildRequirement(
                          "At least 1 special character (!@#\$%^&*)",
                        ),
                      ],
                    ),
                  ),

                  const HeightSpace(height: 20),

                  /// Confirm Password
                  CustomTextField(
                    controller: _confirmPasswordController,
                    validator: (value) => validatePasswordMatch(value ?? ''),
                    hintTextStyle: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff94A3B8),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff334155),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xff94A3B8),
                      size: 25.sp,
                    ),
                    fillColor: Color(0xffF8FAFC),
                    borderColor: Color(0xff94A3B8),
                    radius: 8,
                    textFieldTitle: "Confirm Password",
                    hintText: "Confirm your password",
                    isPassword: true,
                  ),

                  const HeightSpace(height: 32),

                  /// Reset Password Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleResetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const HeightSpace(height: 20),

                  /// Back to Login Link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed(RouteName.authRouteScreen);
                      },
                      child: Text(
                        "Back to Login",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
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
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 14.sp,
            color: Color(0xff94A3B8),
          ),
          const WidthSpace(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
                color: Color(0xff64748B),
              ),
            ),
          ),
        ],
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
