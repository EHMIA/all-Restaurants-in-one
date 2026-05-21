import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';

class CutomLogoTitleSubtitle extends StatelessWidget {
  const CutomLogoTitleSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //logo
        const HeightSpace(height: 32),
        CircleAvatar(
          radius: 35.r,
          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
          child: Icon(
            Icons.restaurant,
            color: AppColors.primaryColor,
            size: 35.sp,
          ),
        ),

        const HeightSpace(height: 12),

        // title
        Text(
          "Akiel",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),

        const HeightSpace(height: 4),

        // subtitle
        Text(
          "Welcome! Login or Create an Account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textGrayColor,
            fontWeight: FontWeight.w600,
          ),
        ),

        const HeightSpace(height: 24),
      ],
    );
  }
}
