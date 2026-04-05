import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailPhoneController = TextEditingController();

  String? validateEmailOrPhone(String emailOrPhone) {
    if (emailOrPhone.isEmpty) {
      return 'Email or phone number cannot be empty';
    }

    // Regular expression for email format
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Regular expression for phone number format (basic)
    final phoneRegex = RegExp(r'^[0-9\+\-\s\(\)]{10,}$');

    if (!emailRegex.hasMatch(emailOrPhone) &&
        !phoneRegex.hasMatch(emailOrPhone)) {
      return 'Please enter a valid email or phone number';
    }

    return null; // Valid
  }

  void _handleSendResetLink() {
    if (_emailPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email or phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (validateEmailOrPhone(_emailPhoneController.text) == null) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP sent successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to OTP verification screen after a short delay
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          GoRouter.of(
            context,
          ).goNamed(RouteName.otpPage, extra: _emailPhoneController.text);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validateEmailOrPhone(_emailPhoneController.text)!),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  /// Back Button
                  const HeightSpace(height: 40),

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
                          "Forgot Password?",
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
                            "Enter the email or phone number associated with your account and we'll send you an OTP to verify your identity.",
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

                  /// Email or Phone TextField
                  CustomTextField(
                    controller: _emailPhoneController,
                    validator: (value) => validateEmailOrPhone(value ?? ''),
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
                      Icons.email_outlined,
                      color: Color(0xff94A3B8),
                      size: 25.sp,
                    ),
                    fillColor: Color(0xffF8FAFC),
                    borderColor: Color(0xff94A3B8),
                    radius: 8,
                    textFieldTitle: "Email or Phone Number",
                    hintText: "e.g. name@email.com",
                    keyBoardType: TextInputType.emailAddress,
                  ),

                  const HeightSpace(height: 32),

                  /// Send OTP Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleSendResetLink,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Send OTP",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: Colors.white,
                            ),
                          ),
                          WidthSpace(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const HeightSpace(height: 24),

                  /// Back to Login Link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pop();
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

  @override
  void dispose() {
    _emailPhoneController.dispose();
    super.dispose();
  }
}
