import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomUserReviewCard extends StatefulWidget {
  final String profileImageUrl;
  final String userName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double rating;
  final String reviewText;
  final VoidCallback? onTap;

  const CustomUserReviewCard({
    super.key,
    required this.profileImageUrl,
    required this.userName,
    required this.createdAt,
    required this.rating,
    required this.reviewText,
    this.onTap, required this.updatedAt,
  });

  @override
  State<CustomUserReviewCard> createState() => _CustomUserReviewCardState();
}

class _CustomUserReviewCardState extends State<CustomUserReviewCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool isEdited = widget.updatedAt.isAfter(
      widget.createdAt.add(const Duration(seconds: 1)),
    );
    String timeAgoText = timeago.format(widget.createdAt, locale: 'en');

    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
          if (widget.onTap != null) widget.onTap!();
        },
        borderRadius: BorderRadius.circular(24.r),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50.h,
                    width: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200.r),
                      child: CachedNetworkImage(
                        imageUrl: widget.profileImageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade200,
                          child: Icon(Icons.person, size: 30.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: TextStyle(
                            fontSize: 15.sp,
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
                                    color: const Color(0xFF939094),
                                  ),
                                ),
                                if (isEdited) ...[
                                  SizedBox(width: 4.w),
                                  Text(
                                    "(Edited)",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color(0xFF939094),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                IconData iconData;
                                if (widget.rating >= index + 1) {
                                  iconData = Icons.star;
                                } else if (widget.rating >= index + 0.5) {
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
              SizedBox(height: 16.h),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Text(
                  widget.reviewText,
                  style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
