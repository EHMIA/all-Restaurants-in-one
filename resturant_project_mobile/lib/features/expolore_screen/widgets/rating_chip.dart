import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class RatingChip extends StatelessWidget {
  const RatingChip({
    super.key,
    required this.rating,
    required this.isSelected,
    required this.onTap,
  });

  final double? rating; // null = "All"
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = rating == null ? 'All' : '${rating}+';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xffe9eefa),
          ),
          borderRadius: BorderRadius.circular(56.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (rating != null) ...[
              Icon(
                Icons.star,
                size: 14.sp,
                color: isSelected ? Colors.white : Colors.amber,
              ),
              WidthSpace(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'Poppins',
                color: isSelected ? Colors.white : AppColors.grayColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
