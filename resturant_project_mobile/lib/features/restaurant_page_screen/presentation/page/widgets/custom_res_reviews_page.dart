import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_page_cubit.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_page_state.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_user_review_card.dart';

class CustomResReviewsPage extends StatelessWidget {
  const CustomResReviewsPage({super.key, this.rate, this.numOfReviews});
  final String? rate;
  final String? numOfReviews;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantPageCubit, RestaurantPageState>(
      builder: (context, state) {
        if (state is RestaurantPageLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (state is RestaurantPageError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.primaryColor,
                    size: 48.sp,
                  ),
                  HeightSpace(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is RestaurantPageSuccess) {
          final review = state.model.data.reviews;
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
                          offset: Offset(0, 10),
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
                              Icons.star,
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
                            GoRouter.of(
                              context,
                            ).pushNamed(RouteName.writeReviewPage);
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
                                Icon(
                                  Icons.edit,
                                  size: 20.sp,
                                  color: Colors.white,
                                ),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: review.length,
                    itemBuilder: (context, index) {
                      return CustomUserReviewCard(
                        title: review[index].title,
                        profileImageUrl:
                            AppAssets.image, //wait backend to finish it
                        name: review[index].userName,
                        timeAgo: review[index].createdAt.toString(),
                        rating: review[index].rating,
                        reviewText: review[index].content,
                        onTap: null,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
