import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/otp_cubit.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/otp_state.dart';

class CustomOtpVerifyButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomOtpVerifyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        final isLoading = state is OtpLoading;
        return GestureDetector(
          onTap: isLoading ? null : onTap,
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: isLoading
                  ? AppColors.primaryColor.withValues(alpha: 0.6)
                  : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.textWhiteColor,
                    )
                  : Text(
                      "Verify OTP",
                      style: TextStyle(
                        color: AppColors.textWhiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
