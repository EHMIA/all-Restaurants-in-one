import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';

class CustomRestaurantCardWithError extends StatelessWidget {
  const CustomRestaurantCardWithError({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 250.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: AppColors.grayColor),
            HeightSpace(height: 8),
            Text(
              "No restaurants available",
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'Poppins',
                color: AppColors.grayColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}