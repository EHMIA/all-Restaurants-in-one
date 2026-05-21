import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constant_data.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../../../bottom_navigation_bar/cubit/layout_cubit.dart';
import '../../../../expolore_screen/presentation/cubit/explore_cubit.dart';

class CustomPopularCuisinesWidget extends StatefulWidget {
  const CustomPopularCuisinesWidget({super.key});

  @override
  State<CustomPopularCuisinesWidget> createState() => _CustomPopularCuisinesWidgetState();
}

class _CustomPopularCuisinesWidgetState extends State<CustomPopularCuisinesWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Text(
            'Popular Cuisines',
            style: TextStyle(
              fontSize: 18.sp,
              color: const Color(0xff0F172A),
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        HeightSpace(height: 16),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: isExpanded ? ConstantData.categories.length : 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              // Show "More" button if collapsed
              if (!isExpanded && index == 3) {
                return _buildToggleItem(
                  icon: Icons.more_horiz,
                  label: "More",
                  onTap: () {
                    setState(() {
                      isExpanded = true;
                    });
                  },
                );
              }

              if (isExpanded && index == ConstantData.categories.length - 1) {
                return _buildToggleItem(
                  icon: Icons.expand_less,
                  label: "Less",
                  onTap: () {
                    setState(() {
                      isExpanded = false;
                    });
                  },
                );
              }

              final cat = ConstantData.categories[index];

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ExploreCubit>().setSearch(cat['title']);
                      context.read<LayoutCubit>().changeTab(1);
                    },
                    child: Container(
                      width: 64.w,
                      height: 64.h,
                      decoration: BoxDecoration(
                        color: cat['color'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        cat['icon'],
                        color: cat['iconColor'],
                        size: 30.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    cat['title'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30.sp),
          ),
          SizedBox(height: 8.h),
          Text(label),
        ],
      ),
    );
  }
}