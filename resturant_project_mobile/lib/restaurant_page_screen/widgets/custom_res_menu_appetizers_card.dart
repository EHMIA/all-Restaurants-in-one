import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomResMenuAppetizersCard extends StatelessWidget {
  const CustomResMenuAppetizersCard({super.key, this.image, this.title, this.description, this.price});
  final String? image;
  final String? title;
  final String? description;
  final String? price;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 12.h, left: 12.w, bottom: 27.h),
        child: Row(
          children: [
            SizedBox(
              width: 96.w,
              height: 96.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(AppAssets.image, fit: BoxFit.fill),
              ),
            ),
            WidthSpace(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'No Title',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Poppins",
                      color: const Color(0xff0F172A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description ?? 'No Description',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Poppins",
                      color: AppColors.grayColor,
                    ),
                  ),
                  Text(
                    price ?? '0 EGP',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}