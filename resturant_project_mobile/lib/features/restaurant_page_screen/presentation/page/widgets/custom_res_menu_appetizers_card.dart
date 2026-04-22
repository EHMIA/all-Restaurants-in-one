import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:shimmer/shimmer.dart';

class CustomResMenuAppetizersCard extends StatelessWidget {
  const CustomResMenuAppetizersCard({super.key, this.image, this.title, this.description, this.price});
  final String? image;
  final String? title;
  final String? description;
  final String? price;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 12.h, left: 12.w, bottom: 27.h),
        child: Row(
          children: [
            SizedBox(
              width: 96.w,
              height: 96.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child:CachedNetworkImage(
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
              ),
            ),
            WidthSpace(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'No Title',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Poppins",
                      color: const Color(0xff0F172A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description ?? 'No Description',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Poppins",
                      color: AppColors.grayColor,
                    ),
                  ),
                  Text(
                    price ?? '0 EGP',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
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