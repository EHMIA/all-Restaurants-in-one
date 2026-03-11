import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(Icons.home_filled, Icons.home_filled, "Home", 0),
          _buildItem(Icons.explore_outlined, Icons.explore, "Explore", 1),
          _buildItem(Icons.favorite_border, Icons.favorite, "Fvorites", 2),
          _buildItem(Icons.person_outline, Icons.person, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildItem(
    IconData icon,
    IconData iconSelected,
    String label,
    int index,
  ) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSelected
              ? Icon(
                  iconSelected,
                  size: 28.sp,
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.grayColor,
                )
              : Icon(
                  icon,
                  size: 28.sp,
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.grayColor,
                ),
          HeightSpace(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "Poppins",
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primaryColor : AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
