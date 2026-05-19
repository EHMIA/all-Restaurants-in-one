import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class RestaurantInfoShimmerLoading extends StatelessWidget {
  const RestaurantInfoShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title Shimmer
              Container(width: 200.w, height: 24.h, color: Colors.white),
              HeightSpace(height: 16),

              /// Description Shimmer
              Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      width: double.infinity,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
              HeightSpace(height: 24),

              /// Location Title Shimmer
              Container(width: 120.w, height: 24.h, color: Colors.white),
              HeightSpace(height: 12),

              /// Location Shimmer
              Column(
                children: List.generate(2, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      width: double.infinity,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
              HeightSpace(height: 24),

              /// Opening Hours Shimmer
              Container(width: 150.w, height: 24.h, color: Colors.white),
              HeightSpace(height: 12),

              /// Hours Card Shimmer
              Container(
                width: double.infinity,
                height: 180.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
