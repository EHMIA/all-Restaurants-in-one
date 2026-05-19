import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class RestaurantHeadShimmerLoading extends StatelessWidget {
  const RestaurantHeadShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380.h,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// Background Image Shimmer
            Container(color: Colors.white),

            /// Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),

            /// Bottom Content Shimmer
            Positioned(
              bottom: 24.h,
              left: 24.w,
              right: 24.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Open Badge Shimmer
                  Container(
                    width: 80.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  HeightSpace(height: 12),

                  /// Name Shimmer
                  Container(width: 250.w, height: 40.h, color: Colors.white),
                  HeightSpace(height: 12),

                  /// Rating Shimmer
                  Row(
                    children: [
                      Container(
                        width: 200.w,
                        height: 20.h,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Container(width: 60.w, height: 20.h, color: Colors.white),
                    ],
                  ),
                  HeightSpace(height: 12),

                  /// Categories Shimmer
                  Row(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Container(
                          width: 80.w,
                          height: 15.h,
                          color: Colors.white,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
