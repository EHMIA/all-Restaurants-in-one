import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_user_review_card.dart';

class CustomResReviewsPage extends StatelessWidget {
  const CustomResReviewsPage({super.key, this.rate, this.numOfReviews, this.resSpace, this.category, this.resName, this.resImage});
final String? rate;
final String? numOfReviews;
final String? resSpace;
final String? category;
final String? resName;
final String? resImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 358.w,
              height: 200.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 10), // X , Y
                  ),
                ],
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeightSpace(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_outline,
                        size: 45.sp,
                        color: Colors.amberAccent,
                      ),
                      WidthSpace(width: 8),
                      Text(
                        rate ?? '0.0',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(height: 8),
                  Text(
                    'Based on ${numOfReviews ?? '0'} reviews',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "Poppins",
                      color: AppColors.grayColor,
                    ),
                  ),
                  HeightSpace(height: 24),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed(RouteName.writeReviewPage, extra: {
                        'image': resImage,
                        'resName': resName,
                        'resRate': rate,
                        'numOfReviews': numOfReviews,
                        'resSpace': resSpace,
                        'category': category,
                      });
                    },
                    child: Container(
                      width: 203.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, size: 20.sp, color: Colors.white),
                          WidthSpace(width: 8),
                          Text(
                            'Write a Review',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HeightSpace(height: 24),
            Text(
              'Recent Reviews',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
            HeightSpace(height: 16),
            CustomUserReviewCard(
              profileImageUrl: AppAssets.image,
              name: 'mohamed',
              timeAgo: '20 hours ago',
              rating: 4,
              reviewText: 'Great food and excellent service!',
              onTap: () {
                //write what u want to do here
              },
            ),
          ],
        ),
      ),
    );
  }
}
