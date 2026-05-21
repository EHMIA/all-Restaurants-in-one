import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constant_validate.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.prefixIcon,
    this.keyBoardType,
    this.validator,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final Widget prefixIcon;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      validator: validator ?? (v) => ConstantValidate().validateEmail(v ?? ''),
      hintTextStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.textFormFieldColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      textStyle: TextStyle(
        fontSize: 16.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        color: AppColors.textFormFieldColor,
      ),
      prefixIcon: prefixIcon,
      fillColor: const Color(0xffF8FAFC),
      borderColor: AppColors.textFormFieldColor,
      radius: 8,
      textFieldTitle: title,
      hintText: hintText,
      keyBoardType: keyBoardType,
    );
  }
}
