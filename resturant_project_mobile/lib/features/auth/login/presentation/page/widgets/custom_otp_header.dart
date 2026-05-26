import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class CustomOtpHeader extends StatelessWidget {
  const CustomOtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeightSpace(height: 40),
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
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const HeightSpace(height: 24),
        Text(
          "Verify OTP",
          style: TextStyle(
            fontSize: 28.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
