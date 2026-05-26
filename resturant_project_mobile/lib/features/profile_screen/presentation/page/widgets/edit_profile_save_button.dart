import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../cubit/edit_profile_cubit.dart';
import '../../cubit/edit_profile_state.dart';
import '../../cubit/profile_cubit.dart';

class EditProfileSaveButton extends StatelessWidget {
  const EditProfileSaveButton({
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          final isLoading = state is EditProfileLoading;

          return GestureDetector(
            onTap: isLoading
                ? null
                : () {
                    context.read<EditProfileCubit>().saveChanges(
                      profileCubit: context.read<ProfileCubit>(),
                      fullname: fullNameController.text.trim(),
                      email: emailController.text.trim(),
                      phone: phoneController.text.trim(),
                      address: addressController.text.trim(),
                    );
                  },
            child: Container(
              width: double.infinity,
              height: 56.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isLoading
                    ? AppColors.primaryColor.withValues(alpha: 0.6)
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isLoading
                  ? SizedBox(
                      height: 24.sp,
                      width: 24.sp,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
