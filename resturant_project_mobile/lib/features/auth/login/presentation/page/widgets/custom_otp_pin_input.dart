import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:resturant_project/core/styles/app_colors.dart';

class CustomOtpPinInput extends StatelessWidget {
  final TextEditingController controller;

  const CustomOtpPinInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: 6,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        textStyle: TextStyle(
          fontSize: 20.sp,
          fontFamily: "Poppins",
          color: AppColors.textGrayColor,
          fontWeight: FontWeight.bold,
        ),
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.textFormFillColor,
          border: Border.all(color: AppColors.textFormFieldColor, width: 2),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
