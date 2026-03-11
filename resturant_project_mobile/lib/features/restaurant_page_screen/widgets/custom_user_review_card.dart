import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomUserReviewCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String timeAgo;
  final int rating;
  final String reviewText;
  final VoidCallback? onTap;

  const CustomUserReviewCard({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.timeAgo,
    required this.rating,
    required this.reviewText,
    this.onTap,
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
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
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
            ],
          ),
        ),
      ),
    );
  }
}
