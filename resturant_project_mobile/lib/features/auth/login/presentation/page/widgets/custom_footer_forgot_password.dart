import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/widgets/spacing_widgets.dart';

class CustomFooterForgotPassword extends StatelessWidget {
  const CustomFooterForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeightSpace(height: 24),
        Center(
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Text(
              "Back to Login",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins",
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        const HeightSpace(height: 24),
      ],
    );
  }
}
