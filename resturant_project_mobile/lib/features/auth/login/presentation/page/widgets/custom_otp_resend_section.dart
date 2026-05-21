import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class CustomOtpResendSection extends StatelessWidget {
  final VoidCallback onResendTap;

  const CustomOtpResendSection({super.key, required this.onResendTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Didn't receive the code?",
          style: TextStyle(color: AppColors.textGrayColor, fontSize: 14.sp),
        ),
        const HeightSpace(height: 8),
        GestureDetector(
          onTap: onResendTap,
          child: Text(
            "Resend OTP",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
