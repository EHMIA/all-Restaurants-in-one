import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/core/widgets/restuarant_status.dart';

class CustomListCards extends StatefulWidget {
  const CustomListCards({
    super.key,
    this.image,
    this.resName,
    this.resRate,
    this.numReviews,
    this.resSpace,
    this.onTap,
    required this.isFavorite,
    this.isOpen,
    this.onFavoriteToggle,
    this.category,
  });

  final String? image;
  final String? resName;
  final String? resRate;
  final String? numReviews;
  final String? resSpace;
  final void Function()? onTap;
  final bool isFavorite;
  final bool? isOpen;
  final void Function()? onFavoriteToggle;
  final String? category;

  @override
  State<CustomListCards> createState() => _CustomListCardsState();
}

class _CustomListCardsState extends State<CustomListCards> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 128.h,
              child: Stack(
                children: [
                  Image.asset(
                    widget.image ?? AppAssets.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    // Show heart button (red or gray) when in favorite screen,
                    // otherwise show open/closed status badge.
                    child: widget.onFavoriteToggle != null
                        ? GestureDetector(
                            onTap: widget.onFavoriteToggle,
                            child: Container(
                              height: 28.h,
                              width: 28.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60.r),
                              ),
                              child: Icon(
                                CupertinoIcons.heart_fill,
                                // Red when favorited, gray when pending removal
                                color: widget.isFavorite
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                                size: 20.sp,
                              ),
                            ),
                          )
                        : widget.isOpen == true
                        ? RestuarantStatus(
                            text: 'OPEN NOW',
                            color: Color(0xff22C55E),
                          )
                        : RestuarantStatus(
                            text: 'CLOSED',
                            color: Color(0xff64748B),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.resName ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  HeightSpace(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18.sp),
                      WidthSpace(width: 4),
                      Text(
                        widget.resRate ?? '0.0',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidthSpace(width: 4),
                      Text(
                        '(${widget.numReviews ?? "0"})',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Color(0xff94A3B8),
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(height: 4.h),
                  Text(
                    '${widget.category} • ${widget.resSpace}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xff64748B),
                      fontFamily: 'Poppins',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            HeightSpace(height: 12),
          ],
        ),
      ),
    );
  }
}
