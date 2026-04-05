import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomFeaturedRestaurantsCard extends StatelessWidget {
  const CustomFeaturedRestaurantsCard({
    super.key,
    this.image,
    this.titleText,
    this.restaurantRate,
    this.spaceToRestaurant, this.onTap, required this.isFavorite, required this.isOpen, this.category, this.onFavoriteToggle,
  });
  final String? image;
  final String? titleText;
  final String? restaurantRate;
  final String? spaceToRestaurant;
  final String? category;
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
                    Image.asset(
                      image ?? AppAssets.homeImage,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
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
                          color: isOpen?  Colors.green:Colors.grey,
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
                        titleText ?? 'Kebda & Sogoq House',
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
                          restaurantRate ?? '5',
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
                child: Text(
                  '${category?? 'No Category'} • ${spaceToRestaurant??'0.0 km'}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.grayColor,
                    fontFamily: 'Poppins',
                  ),
                  overflow: TextOverflow.ellipsis,
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
