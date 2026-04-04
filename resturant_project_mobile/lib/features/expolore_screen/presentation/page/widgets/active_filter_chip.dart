import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';

class ActiveFilterChip extends StatelessWidget {
  const ActiveFilterChip({
    super.key,
    required this.label,
    required this.onRemove,
  });

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.primaryColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        deleteIcon: Icon(
          Icons.close,
          size: 14.sp,
          color: AppColors.primaryColor,
        ),
        onDeleted: onRemove,
        backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
        side: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(56.r),
        ),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
