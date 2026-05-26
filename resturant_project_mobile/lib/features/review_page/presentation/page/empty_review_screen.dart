import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class EmptyReviewScreen extends StatelessWidget {
  const EmptyReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhiteColor,
      body: Column(
        children: [
          SizedBox(
            height: 417.h,
            width: double.infinity,
            child: Column(
              children: [
                HeightSpace(height: 80),
                Icon(
                  CupertinoIcons.star,
                  size: 110.sp,
                  color: Color(0xffCBD5E1),
                ),
                HeightSpace(height: 24),
                Text(
                  "No Reviews Was Written",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    color: AppColors.grayColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                HeightSpace(height: 8),
                Text(
                  textAlign: TextAlign.center,
                  'Start writting your reviews about restaurants from\ntheir profile pages to see them here.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "Poppins",
                    color: AppColors.grayColor,
                  ),
                ),
                HeightSpace(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
