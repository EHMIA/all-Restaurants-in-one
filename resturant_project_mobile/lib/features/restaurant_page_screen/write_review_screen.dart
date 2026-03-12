import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/managers/review_manager.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_bottom.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({
    super.key,
    this.resName,
    this.resImage,
    this.resRate,
    this.numOfReviews,
    this.resSpace,
    this.category,
    this.restaurantId,
    this.userId,
  });
  final String? resName;
  final String? resImage;
  final String? resRate;
  final String? numOfReviews;
  final String? resSpace;
  final String? category;
  final String? restaurantId;
  final String? userId;

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<_RatingWidgetState> ratingWidgetKey = GlobalKey();

  List<File> selectedImages = [];

  /// Pick multiple images from gallery
  void _pickImagesFromGallery() async {
    try {
      final List<XFile> pickedFiles = await _imagePicker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          selectedImages.addAll(
            pickedFiles.map((xFile) => File(xFile.path)).toList(),
          );
        });
      }
    } catch (e) {
      print('Error picking images: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error selecting images')));
    }
  }

  /// Remove an image from the selected list
  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  /// Post review and navigate back
  void _postReview() {
    String review = reviewController.text;
    double rating = ratingWidgetKey.currentState?.rating ?? 0.0;

    if (review.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please write a review')));
      return;
    }

    if (rating == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a rating')));
      return;
    }

    // Create review data map to send back
    final reviewData = {
      'userId':
          widget.userId ??
          'user_1', // TODO: Replace with actual user ID from auth
      'userName':
          'Current User', // TODO: Replace with actual user name from firebase or auth
      'userProfileImage': '', // TODO: Add user profile image
      'title': titleController.text,
      'review': review,
      'rating': rating,
      'images': selectedImages,
      'timestamp': DateTime.now(),
    };

    // Save review to ReviewManager
    if (widget.restaurantId != null) {
      ReviewManager().addReview(widget.restaurantId!, reviewData);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review posted successfully!')),
    );

    // Navigate back and pass the review data
    Navigator.of(context).pop(reviewData);
  }

  @override
  void dispose() {
    titleController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Write a Review",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// RESTAURANT INFO
              Row(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: Image.asset(
                        widget.resImage ?? AppAssets.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  WidthSpace(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.resName ?? 'Without Name',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff0F172A),
                        ),
                      ),

                      HeightSpace(height: 4),

                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),

                          WidthSpace(width: 4),

                          Text(
                            widget.resRate ?? '0.0',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          WidthSpace(width: 6),

                          Text(
                            '(${widget.numOfReviews ?? '0'} reviews)',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xff94A3B8),
                            ),
                          ),
                        ],
                      ),

                      HeightSpace(height: 4),

                      Text(
                        '${widget.category ?? 'No Category'} • ${widget.resSpace ?? '0.0'} km away',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xff94A3B8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              HeightSpace(height: 24),

              /// CARD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Padding(
                  padding: EdgeInsets.all(20.w),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// EXPERIENCE TEXT
                      Center(
                        child: Text(
                          'How was your experience?',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xff334155),
                          ),
                        ),
                      ),

                      HeightSpace(height: 12),

                      RatingWidget(key: ratingWidgetKey),

                      HeightSpace(height: 28),

                      /// REVIEW TITLE
                      Text(
                        "REVIEW TITLE (OPTIONAL)",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xff94A3B8),
                          letterSpacing: 1,
                        ),
                      ),

                      HeightSpace(height: 8),

                      CustomTextField(
                        controller: titleController,
                        hintText: "Summarize your visit",
                        radius: 16,
                      ),

                      HeightSpace(height: 20),

                      /// SHARE EXPERIENCE
                      Text(
                        "SHARE YOUR EXPERIENCE",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xff94A3B8),
                          letterSpacing: 1,
                        ),
                      ),

                      HeightSpace(height: 8),

                      CustomTextField(
                        controller: reviewController,
                        hintText:
                            "What did you love? How was the service and the atmosphere?",
                        maxLines: 6,
                        radius: 16,
                      ),

                      HeightSpace(height: 24),

                      /// ADD PHOTOS
                      Text(
                        "ADD PHOTOS",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xff94A3B8),
                          letterSpacing: 1,
                        ),
                      ),

                      HeightSpace(height: 12),

                      SizedBox(
                        height: 100.h,

                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            /// ADD PHOTO BUTTON
                            GestureDetector(
                              onTap: _pickImagesFromGallery,
                              child: Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.orange,
                                    ),

                                    HeightSpace(height: 6),

                                    Text(
                                      "ADD PHOTOS",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            WidthSpace(width: 12),

                            /// PHOTOS
                            ...selectedImages.asMap().entries.map((entry) {
                              int index = entry.key;
                              File image = entry.value;
                              return Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.file(
                                        image,
                                        width: 100.w,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () => _removeImage(index),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: EdgeInsets.all(4.w),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              HeightSpace(height: 24),
              CustomTextButton(
                width: double.infinity,
                backgroundColor: AppColors.primaryColor,
                onTap: _postReview,
                text: 'Post Review',
                textColor: Colors.white,
                isIcon: false,
              ),
              HeightSpace(height: 24),
              CustomTextButton(
                width: double.infinity,
                backgroundColor: Color(0xffF1F5F9),
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancel',
                textColor: Colors.black,
                isIcon: false,
              ),
              HeightSpace(height: 96),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double rating = 0.0;

  double get getRating => rating;

  String getRatingText() {
    if (rating >= 4.5) return "Excellent!";
    if (rating >= 4) return "Great!";
    if (rating >= 3) return "Good!";
    if (rating >= 2) return "Bad!";
    return "Very Bad!";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// STARS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTapDown: (details) {
                double dx = details.localPosition.dx;

                if (dx < 20) {
                  rating = index + 0.5;
                } else {
                  rating = index + 1;
                }

                setState(() {});
              },

              child: Icon(
                rating >= index + 1
                    ? Icons.star
                    : rating >= index + 0.5
                    ? Icons.star_half
                    : Icons.star_border,
                color: Colors.amber,
                size: 35.sp,
              ),
            );
          }),
        ),

        HeightSpace(height: 8),

        Text(
          getRatingText(),
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
