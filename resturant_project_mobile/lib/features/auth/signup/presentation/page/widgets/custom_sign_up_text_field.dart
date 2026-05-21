import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';

class CustomSignUpTextField extends StatelessWidget {
  final TextEditingController controller;
  final String textFieldTitle;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyBoardType;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomSignUpTextField({
    super.key,
    required this.controller,
    required this.textFieldTitle,
    required this.hintText,
    required this.prefixIcon,
    this.keyBoardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      validator: validator,
      hintTextStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.textFormFieldColor,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins",
      ),
      textStyle: TextStyle(
        fontSize: 16.sp,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        color: AppColors.textFormFieldColor,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.textFormFieldColor,
        size: 25.sp,
      ),
      fillColor: const Color(0xffF8FAFC),
      borderColor: AppColors.textFormFieldColor,
      radius: 8,
      textFieldTitle: textFieldTitle,
      hintText: hintText,
      keyBoardType: keyBoardType,
      isPassword: isPassword,
    );
  }
}
