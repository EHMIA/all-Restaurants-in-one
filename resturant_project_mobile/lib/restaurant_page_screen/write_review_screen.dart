import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_bottom.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});
  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  List<String> images = [AppAssets.image, AppAssets.image];

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
                      child: Image.asset(AppAssets.image, fit: BoxFit.cover),
                    ),
                  ),

                  WidthSpace(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sobhy Kaber',
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
                            '4.5',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          WidthSpace(width: 6),

                          Text(
                            '(1,234 reviews)',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xff94A3B8),
                            ),
                          ),
                        ],
                      ),

                      HeightSpace(height: 4),

                      Text(
                        'Egyptian • 2.1 km away',
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
                      color: Colors.black.withOpacity(.1),
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

                      const RatingWidget(),

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
                            Container(
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: Colors.grey.shade300),
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

                            WidthSpace(width: 12),

                            /// PHOTOS
                            ...images.map((image) {
                              return Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: Image.asset(
                                    image,
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  ),
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
              CustomTextButton(
                backgroundColor: AppColors.primaryColor,
                onTap: () {},
                text: 'Post Review',
                textColor: Colors.white,
                isIcon: false,
              ),
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
  double rating = 0;

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
