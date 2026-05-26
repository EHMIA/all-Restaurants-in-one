import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import 'edit_profile_notification_toggel.dart';
import 'edit_profile_text_field.dart';

class EditProfileFieldsCard extends StatelessWidget {
  const EditProfileFieldsCard({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              HeightSpace(height: 15),
              EditProfileTextField(
                controller: fullNameController,
                title: 'Full Name',
                hintText: 'Enter your full name',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.textFormFieldColor,
                  size: 25.sp,
                ),
              ),
              HeightSpace(height: 15),
              EditProfileTextField(
                controller: emailController,
                title: 'Email Address',
                hintText: 'Enter your email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.textFormFieldColor,
                  size: 25.sp,
                ),
                keyBoardType: TextInputType.emailAddress,
              ),
              HeightSpace(height: 15),
              EditProfileTextField(
                controller: phoneController,
                title: 'Phone Number',
                hintText: 'Enter your phone number',
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: AppColors.textFormFieldColor,
                  size: 25.sp,
                ),
                keyBoardType: TextInputType.phone,
              ),
              HeightSpace(height: 15),
              EditProfileTextField(
                controller: addressController,
                title: 'Address',
                hintText: 'Enter your address',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.textFormFieldColor,
                  size: 25.sp,
                ),
              ),
              HeightSpace(height: 15),
              EditProfileNotificationsToggle(),
              HeightSpace(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
