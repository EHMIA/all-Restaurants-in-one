import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomCategoryItemWidget extends StatelessWidget {
  const CustomCategoryItemWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    required this.isSelected,
  });
  final String title;
  final Function() onTap;
  final IconData? icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: InkWell(
        radius: 56.r,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Color(0xffe9eefa),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(56.r),
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
          ),
          child: Row(
            children: [
              isSelected ? Icon(icon, color: Colors.white) : Icon(icon),
              if (icon != null) WidthSpace(width: 8),
              if (icon != null) WidthSpace(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: isSelected ? Colors.white : AppColors.grayColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
