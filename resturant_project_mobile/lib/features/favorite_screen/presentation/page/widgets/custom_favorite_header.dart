import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';

class CustomFavoriteHeader extends StatelessWidget {
  final int favoritesCount;

  const CustomFavoriteHeader({super.key, required this.favoritesCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffFAFAFA), Color(0xffFFFDE7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 31.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  constraints: BoxConstraints(minWidth: 107.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: const Color(0xffE23744).withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: Text(
                      "$favoritesCount restaurants",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            HeightSpace(height: 8),
            Text(
              "All the restaurants you loved and saved.",
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Poppins",
                color: const Color(0xff475569),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
