import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';

import '../core/widgets/spacing_widgets.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Reviews",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('clicked');
            },
            icon: Icon(Icons.filter_list, color: AppColors.primaryColor),
          ),
          WidthSpace(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(height: 32),
              Text(
                "My Reviews",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              HeightSpace(height: 4),
              Text(
                'All the reviews you have written',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "Poppins",
                  color: AppColors.grayColor,
                ),
              ),
              HeightSpace(height: 16),
              Container(
                width: 100.w,
                height: 32.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  '8 Reviews',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              HeightSpace(height: 56),
              Container(
                margin: EdgeInsets.only(bottom: 16.sp),
                width: 358.w,
                constraints: BoxConstraints(minHeight: 331.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(21.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                AppAssets.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          WidthSpace(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'The Golden Bistro',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Jan 15, 2026',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.grayColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      HeightSpace(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 25.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 25.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 25.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 25.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 25.sp,
                          ),
                          WidthSpace(width: 8),
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      HeightSpace(height: 8),
                      Text(
                        'Amazing food and service!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      HeightSpace(height: 8),
                      Text(
                        '''The atmosphere was wonderful and thesteaks were cooked to perfection.Definitely coming back for the weekendbrunch.''',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16.sp,
                          color: AppColors.grayColor,
                        ),
                      ),
                      HeightSpace(height: 29),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('clicked');
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColors.primaryColor,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Poppins',
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
