import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/app_assets/app_assets.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/widgets/spacing_widgets.dart';

class CustomLogoTitleSubtitleForgotPassword extends StatelessWidget {
  const CustomLogoTitleSubtitleForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeightSpace(height: 40),
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                child: SvgPicture.asset(AppAssets.logo),
              ),
              const HeightSpace(height: 16),
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
              SizedBox(
                width: 280.w,
                child: Text(
                  "Enter the email or phone number associated with your account and we'll send you an OTP to verify your identity.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    color: AppColors.textGrayColor,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const HeightSpace(height: 40),
      ],
    );
  }
}
