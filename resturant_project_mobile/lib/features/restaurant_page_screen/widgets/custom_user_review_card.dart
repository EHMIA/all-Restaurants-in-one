import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomUserReviewCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String timeAgo;
  final double rating;
  final String reviewText;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const CustomUserReviewCard({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.timeAgo,
    required this.rating,
    required this.reviewText,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black.withValues(alpha: 0.6),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with profile image, name, and time
              Row(
                children: [
                  // Profile image with fallback
                  CircleAvatar(
                    backgroundImage: profileImageUrl.startsWith('http')
                        ? NetworkImage(profileImageUrl)
                        : AssetImage(profileImageUrl) as ImageProvider,
                    radius: 24.r,
                    onBackgroundImageError: (_, __) => const Icon(Icons.person),
                  ),
                  const WidthSpace(width: 12),
                  // Name and time column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const HeightSpace(height: 4),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      IconData starIcon;
                      if (index < rating.floor()) {
                        // Full star
                        starIcon = Icons.star;
                      } else if (index == rating.floor() && rating % 1 > 0) {
                        // Half star
                        starIcon = Icons.star_half;
                      } else {
                        // Empty star
                        starIcon = Icons.star_border;
                      }
                      return Icon(starIcon, color: Colors.amber, size: 20);
                    }),
                  ),
                ],
              ),
              const HeightSpace(height: 12),
              // Review text
              Text(
                reviewText,
                style: TextStyle(fontSize: 15.sp, height: 1.4.h),
              ),
              if (onDelete != null) ...[
                const HeightSpace(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red, size: 20),
                        const WidthSpace(width: 4),
                        Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
