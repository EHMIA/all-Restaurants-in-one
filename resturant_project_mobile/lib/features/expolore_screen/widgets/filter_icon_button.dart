import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({
    super.key,
    required this.hasActiveFilter,
    required this.onTap,
  });

  final bool hasActiveFilter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 48.h,
        width: 48.w,
        decoration: BoxDecoration(
          color: hasActiveFilter
              ? AppColors.primaryColor
              : const Color(0xffe9eefa),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.tune_rounded,
              color: hasActiveFilter ? Colors.white : AppColors.grayColor,
              size: 22.sp,
            ),
            if (hasActiveFilter)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
