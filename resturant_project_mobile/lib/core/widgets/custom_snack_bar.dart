import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      snackBarAnimationStyle: AnimationStyle(curve: Curves.easeInOut, duration: const Duration(milliseconds: 800),reverseCurve: Curves.easeInOut),
      SnackBar(
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        elevation: 3,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        backgroundColor:
            backgroundColor ?? AppColors.primaryColor,
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14.sp, 
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: AppColors.textWhiteColor,
          ),
        ),
      ),
    );
  }
}
