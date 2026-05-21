import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class CustomResetPasswordHeader extends StatelessWidget {
  const CustomResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            style: TextStyle(fontSize: 14.sp, color: AppColors.textGrayColor),
          ),
        ],
      ),
    );
  }
}
