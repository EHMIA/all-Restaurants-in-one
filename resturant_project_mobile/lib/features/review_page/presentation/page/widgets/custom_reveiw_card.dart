import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/app_assets/app_assets.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../../../restaurant_page_screen/presentation/page/write_review_screen.dart';

class CustomReveiwCard extends StatefulWidget {
  final String resName;
  final DateTime createdAt;
  final double starRating;
  final String content;
  final VoidCallback? onDeleteTap;

  const CustomReveiwCard({
    super.key,
    required this.resName,
    required this.createdAt,
    required this.starRating,
    required this.content,
    this.onDeleteTap,
  });

  @override
  State<CustomReveiwCard> createState() => _CustomReveiwCardState();
}

class _CustomReveiwCardState extends State<CustomReveiwCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String timeAgoText = timeago.format(widget.createdAt, locale: 'en');

    return Card(
      elevation: 3,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        borderRadius: BorderRadius.circular(24.r),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section (Image, Restaurant Name, Time and Rating)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(AppAssets.image, fit: BoxFit.cover),
                    ),
                  ),
                  WidthSpace(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.resName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1D1B20),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  timeAgoText,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    color: AppColors.grayColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                IconData iconData;
                                if (widget.starRating >= index + 1) {
                                  iconData = Icons.star;
                                } else if (widget.starRating >= index + 0.5) {
                                  iconData = Icons.star_half;
                                } else {
                                  iconData = Icons.star_border;
                                }

                                return Icon(
                                  iconData,
                                  color: Colors.amber,
                                  size: 14.sp,
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              HeightSpace(height: 16),

              // Collapsible Review Content Section
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.content,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14.sp,
                      color: const Color(0xFF49454F),
                      height: 1.3,
                    ),
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                ),
              ),
              HeightSpace(height: 16),

              // Bottom Section (Delete Button Action)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: widget.onDeleteTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: AppColors.primaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 14.sp,
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
      ),
    );
  }
}
