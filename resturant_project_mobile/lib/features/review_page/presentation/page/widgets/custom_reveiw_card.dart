import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_assets/app_assets.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../../../restaurant_page_screen/presentation/page/write_review_screen.dart';

class CustomReveiwCard extends StatelessWidget {
  const CustomReveiwCard({super.key, required this.resName, required this.timeReview, required this.starRating, required this.content, this.onTap});
  final String resName;
  final String timeReview;
  final int starRating;
  final String content;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                    resName,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    timeReview,
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
                              RatingWidget(initialRating: starRating.toDouble(),onChanged: (rating) {
                                
                              },),
                              WidthSpace(width: 8),
                              Text(
                                '$starRating',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          HeightSpace(height: 8),
                          // Text(
                          //   'Amazing food and service!',
                          //   style: TextStyle(
                          //     fontSize: 18.sp,
                          //     fontFamily: 'Poppins',
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          HeightSpace(height: 8),
                          Text(
                            content,
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
                                onTap: onTap,
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
                  );
  }
}