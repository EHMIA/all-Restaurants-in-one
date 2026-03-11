import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/managers/review_manager.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_user_review_card.dart';

class CustomResReviewsPage extends StatefulWidget {
  const CustomResReviewsPage({
    super.key,
    this.rate,
    this.numOfReviews,
    this.resSpace,
    this.category,
    this.resName,
    this.resImage,
    this.reviews,
    this.restaurantId,
  });

  final String? rate;
  final String? numOfReviews;
  final String? resSpace;
  final String? category;
  final String? resName;
  final String? resImage;
  final List<Map<String, dynamic>>? reviews;
  final String? restaurantId;

  @override
  State<CustomResReviewsPage> createState() => _CustomResReviewsPageState();
}

class _CustomResReviewsPageState extends State<CustomResReviewsPage> {
  late List<Map<String, dynamic>> allReviews;
  late double currentRate;
  late String currentNumOfReviews;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  void _loadReviews() {
    if (widget.restaurantId != null) {
      allReviews = ReviewManager().getReviewsForRestaurant(
        widget.restaurantId!,
      );
    } else {
      allReviews = widget.reviews ?? [];
    }
    _updateRating();
  }

  void _updateRating() {
    if (allReviews.isEmpty) {
      currentRate = double.parse(widget.rate ?? '0.0');
      currentNumOfReviews = widget.numOfReviews ?? '0';
    } else {
      double totalRating = allReviews.fold(0.0, (sum, review) {
        return sum + (review['rating'] as num).toDouble();
      });
      currentRate = (totalRating / allReviews.length);
      currentNumOfReviews = allReviews.length.toString();
    }
  }

  void _addNewReview(Map<String, dynamic> reviewData) {
    setState(() {
      allReviews.insert(0, reviewData);
      _updateRating();
    });
  }

  void _deleteReview(int index) {
    setState(() {
      allReviews.removeAt(index);

      // Remove from ReviewManager
      if (widget.restaurantId != null) {
        ReviewManager().deleteReview(widget.restaurantId!, index);
      }

      _updateRating();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// RATING CARD
            Container(
              width: 358.w,
              height: 200.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeightSpace(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, size: 45.sp, color: Colors.amber),
                      WidthSpace(width: 8),
                      Text(
                        currentRate.toStringAsFixed(1),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(height: 8),
                  Text(
                    'Based on $currentNumOfReviews reviews',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "Poppins",
                      color: AppColors.grayColor,
                    ),
                  ),
                  HeightSpace(height: 24),
                  GestureDetector(
                    onTap: () async {
                      final result = await GoRouter.of(context).pushNamed(
                        RouteName.writeReviewPage,
                        extra: {
                          'image': widget.resImage,
                          'resName': widget.resName,
                          'resRate': widget.rate,
                          'numOfReviews': widget.numOfReviews,
                          'resSpace': widget.resSpace,
                          'category': widget.category,
                          'restaurantId': widget.restaurantId,
                          'userId':
                              'user_1', // TODO: Replace with actual user ID from auth
                        },
                      );

                      if (result != null && result is Map<String, dynamic>) {
                        _addNewReview(result);
                      }
                    },
                    child: Container(
                      width: 203.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, size: 20.sp, color: Colors.white),
                          WidthSpace(width: 8),
                          Text(
                            'Write a Review',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HeightSpace(height: 24),
            Text(
              'Recent Reviews',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
            HeightSpace(height: 16),
            allReviews.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        'No reviews yet. Be the first to review!',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allReviews.length,
                    itemBuilder: (context, index) {
                      final review = allReviews[index];
                      final rating = (review['rating'] as num).toDouble();
                      final timeAgo = _getTimeAgo(
                        review['timestamp'] as DateTime,
                      );

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomUserReviewCard(
                          profileImageUrl: AppAssets.image,
                          name: review['userName'] ?? 'Anonymous',
                          timeAgo: timeAgo,
                          rating: rating,
                          reviewText: review['review'] ?? '',
                          onTap: () {
                            // Handle review tap if needed
                          },
                          onDelete: () => _deleteReview(index),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    }
  }
}
