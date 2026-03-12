import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';

class CustomResPhotoPage extends StatelessWidget {
  const CustomResPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            'Photos',
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '156 Photos from guests & owner',
            style: TextStyle(
              fontFamily: "poppins",
              fontSize: 12.sp,
              color: AppColors.grayColor,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6.w,
                mainAxisSpacing: 6.h,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  height: 173.h,
                  width: 173.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.asset(AppAssets.image, fit: BoxFit.fill),
                  ),
                );
              },
            ),
          ),
              ],
            ),
          );
  }
}
