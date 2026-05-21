import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/write_review_screen.dart';
import 'package:resturant_project/features/review_page/presentation/cubit/reviews_cubit.dart';
import 'package:resturant_project/features/review_page/presentation/page/empty_review_screen.dart';
import 'package:resturant_project/features/review_page/presentation/page/widgets/custom_reveiw_card.dart';

import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/reviews_state.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    context.read<ReviewsCubit>().getUserReviews();
    super.initState();
  }

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
              //print('clicked');
            },
            icon: Icon(Icons.filter_list, color: AppColors.primaryColor),
          ),
          WidthSpace(width: 16),
        ],
      ),
      body: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }
          
          if (state is ReviewError) {
            return const EmptyReviewScreen();
          }
          if (state is ReviewSuccess) {
            if (state.review.isEmpty) {
              return const EmptyReviewScreen();
            }
            return SingleChildScrollView(
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
                        '${state.review.length} Reviews',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    HeightSpace(height: 56),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.review.length,
                      itemBuilder: (context, index) {
                        final review = state.review[index];

                        return CustomReveiwCard(
                          resName: review.restaurant?.name ?? 'Unknown Restaurant',
                          timeReview: review.createdAt.toString(),
                          starRating: review.rating,
                          content: review.content,
                          onTap: (){
                            if (review.restaurant != null) {
                              context.read<ReviewsCubit>().deleteReview(
                                review.restaurant!.id,
                              );
                            }
                          },
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
      ),
    );
  }
}
