import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:shimmer/shimmer.dart';

class CustomFeaturedRestaurantsCard extends StatelessWidget {
  const CustomFeaturedRestaurantsCard({
    super.key,
    this.image,
    this.titleText,
    this.restaurantRate,
    this.categories,
    this.onTap,
    required this.isFavorite,
    required this.isOpen,
    this.onFavoriteToggle,
  });
  final String? image;
  final String? titleText;
  final String? restaurantRate;
  final List<String>? categories;
  final void Function()? onTap;
  final bool isFavorite;
  final bool isOpen;
  final void Function()? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 288.w,
        child: Card(
          color: AppColors.backgroundWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160.h,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: image ?? AppAssets.homeImage,

                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,

                      memCacheWidth: 600,
                      memCacheHeight: 400,

                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(color: Colors.white),
                      ),

                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade200,
                        child: Icon(Icons.broken_image_rounded, size: 40.sp),
                      ),
                    ),
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isOpen ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          isOpen ? "OPEN NOW" : "CLOSED",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        titleText ?? 'Un Titled Restaurant',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18.sp),
                        SizedBox(width: 4.w),
                        Text(
                          restaurantRate ?? '0.0',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              HeightSpace(height: 4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (categories?.length ?? 0) > 4
                        ? 4
                        : (categories?.length ?? 0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Text(
                          categories![index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grayColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              HeightSpace(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
