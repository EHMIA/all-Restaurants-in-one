import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/manager/favorite_manager.dart';
import 'package:resturant_project/features/core/widgets/restuarant_status.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/restaurant_page_screen/widgets/custom_button_res_page.dart';

class CustomResPageHead extends StatefulWidget {
  const CustomResPageHead({
    super.key,
    this.image,
    this.numReviews,
    this.category, this.isOpen, this.resName, this.resRate, this.resSpace,
  });
  final String? image;
  final String? resName;
  final String? resRate;
  final String? numReviews;
  final String? resSpace;
  final String? category;
  final bool? isOpen;

  @override
  State<CustomResPageHead> createState() => _CustomResPageHeadState();
}

class _CustomResPageHeadState extends State<CustomResPageHead> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();

    isFavorite = FavoriteManager.favorites.any(
      (element) => element['resName'] == widget.resName,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Background Image
          Image.asset(widget.image ?? AppAssets.image, fit: BoxFit.cover),

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

          /// Top Buttons
          Positioned(
            top: 48.h,
            left: 16.w,
            child: CustomButtonResPage(
              onTap: () {
                GoRouter.of(context).pop();
              },
              icon: Icons.arrow_back,
            ),
          ),

          Positioned(
            top: 48.h,
            right: 16.w,
            child: CustomButtonResPage(
              onTap: () {
                final restaurant = {
                  "resName": widget.resName,
                  "image": widget.image,
                  "resRate": widget.resRate,
                  "resSpace": widget.resSpace,
                  "resPeopleRate": widget.numReviews,
                  "isOpen": widget.isOpen,
                };

                setState(() {
                  FavoriteManager.toggleFavorite(restaurant);
                  isFavorite = !isFavorite;
                });
              },
              icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),

          /// Bottom Content
          Positioned(
            bottom: 24.h,
            left: 24.w,
            right: 24.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Open Now Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isOpen==true?Color(0xff22C55E): Color(0xff64748B),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    widget.isOpen == true ? 'OPEN NOW' : 'CLOSED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                ),
                ),

                HeightSpace(height: 12),

                /// Title
                Text(
                  widget.resName ?? "Without Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                HeightSpace(height: 8.h),

                /// Rating Row
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.amber,
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),

                    Text(
                      widget.resRate ?? "0.0",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),

                    SizedBox(width: 6.w),

                    Text(
                      "(${widget.numReviews ?? '0'} reviews)",
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),

                    SizedBox(width: 8.w),
                    Text("•", style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 8.w),

                    Text(
                      widget.category ?? "Unknown",
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),

                    SizedBox(width: 8.w),
                    Text("•", style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 8.w),

                    Text(
                      widget.resSpace ?? "0 km",
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
