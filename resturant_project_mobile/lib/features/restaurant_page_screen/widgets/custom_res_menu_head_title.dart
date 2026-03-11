import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';

class CustomResMenuHeadTitle extends StatelessWidget {
  const CustomResMenuHeadTitle({super.key, this.appetizersItemsCount, this.title});
  final int? appetizersItemsCount;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? 'NO Title',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${appetizersItemsCount ?? 0} Items',
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 12.sp,
                    color: AppColors.grayColor,
                  ),
                ),
              ],
            );
  }
}