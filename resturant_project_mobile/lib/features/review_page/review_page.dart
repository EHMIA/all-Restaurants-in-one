import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/managers/review_manager.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';

import '../core/widgets/spacing_widgets.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late List<Map<String, dynamic>> userReviews;
  final String currentUserId =
      'user_1'; // TODO: Replace with actual user ID from auth

  @override
  void initState() {
    super.initState();
    _loadUserReviews();
  }

  void _loadUserReviews() {
    setState(() {
      userReviews = ReviewManager().getUserReviews(currentUserId);
    });
  }

  void _deleteReview(int index) {
    final review = userReviews[index];
    final restaurantId = review['restaurantId'] as String?;
    final userId = review['userId'] as String?;
    final timestamp = review['timestamp'] as DateTime?;

    if (restaurantId != null && userId != null && timestamp != null) {
      if (ReviewManager().deleteReviewByUserAndTime(
        restaurantId,
        userId,
        timestamp,
      )) {
        setState(() {
          userReviews.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review deleted successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Reviews",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('clicked');
            },
            icon: Icon(Icons.filter_list, color: AppColors.primaryColor),
          ),
          WidthSpace(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(height: 32),
              Text(
                "My Reviews",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              HeightSpace(height: 4),
              Text(
                'All the reviews you have written',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "Poppins",
                  color: AppColors.grayColor,
                ),
              ),
              HeightSpace(height: 16),
              Container(
                width: 100.w,
                height: 32.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  '${userReviews.length} Reviews',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              HeightSpace(height: 32),
              userReviews.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 48.h),
                        child: Text(
                          'No reviews yet. Write your first review!',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.grayColor,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userReviews.length,
                      itemBuilder: (context, index) {
                        final review = userReviews[index];
                        return _buildReviewCard(review, index);
                      },
                    ),
              HeightSpace(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review, int index) {
    final restaurantName = review.containsKey('restaurantName')
        ? review['restaurantName']
        : 'Restaurant';

    return Container(
      margin: EdgeInsets.only(bottom: 16.sp),
      width: 358.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(21.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(AppAssets.image, fit: BoxFit.fill),
                  ),
                ),
                WidthSpace(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurantName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _formatDate(review['timestamp'] as DateTime),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            HeightSpace(height: 12),
            Row(
              children: [
                ...List.generate(5, (starIndex) {
                  IconData starIcon;
                  final reviewRating = review['rating'] as num;
                  if (starIndex < reviewRating.floor()) {
                    starIcon = Icons.star;
                  } else if (starIndex == reviewRating.floor() &&
                      reviewRating % 1 > 0) {
                    starIcon = Icons.star_half;
                  } else {
                    starIcon = Icons.star_border;
                  }
                  return Icon(starIcon, color: Colors.amber, size: 25.sp);
                }),
                WidthSpace(width: 8),
                Text(
                  (review['rating'] as num).toStringAsFixed(1),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            HeightSpace(height: 8),
            if (review['title'] != null && review['title'].isNotEmpty)
              Text(
                review['title'] as String,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (review['title'] != null && review['title'].isNotEmpty)
              HeightSpace(height: 8),
            Text(
              review['review'] as String? ?? '',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16.sp,
                color: AppColors.grayColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            HeightSpace(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _deleteReview(index),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                      WidthSpace(width: 4),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16.sp,
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
    );
  }

  String _formatDate(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }
}
