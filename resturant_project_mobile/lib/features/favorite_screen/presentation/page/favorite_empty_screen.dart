import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class FavoriteEmptyScreen extends StatelessWidget {
  const FavoriteEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(
            height: 417.h,
            width: double.infinity,
            child: Column(
              children: [
                HeightSpace(height: 80),
                Icon(
                  CupertinoIcons.heart,
                  size: 110.sp,
                  color: Color(0xffCBD5E1),
                ),
                HeightSpace(height: 24),
                Text(
                  "No saved restaurants yet!",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    color: AppColors.grayColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                HeightSpace(height: 8),
                Text(
                  textAlign: TextAlign.center,
                  'Start saving your favorite restaurants from\ntheir profile pages to see them here.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: "Poppins",
                    color: AppColors.grayColor,
                  ),
                ),
                HeightSpace(height: 32),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(RouteName.explorScreen);
                  },
                  child: Container(
                    width: 267.w,
                    height: 48.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Text(
                      'Discover New Restaurants',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
