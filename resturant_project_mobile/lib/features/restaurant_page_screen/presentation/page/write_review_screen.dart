import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/review_page/presentation/cubit/reviews_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../profile_screen/presentation/cubit/profile_cubit.dart';
import '../../../review_page/presentation/cubit/reviews_state.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({
    super.key,
    required this.restuarantId,
    required this.restuarantName,
    required this.restuarantRate,
    required this.restuarantReview,
    required this.restaurantImage,
  });
  final String restuarantId;
  final String restuarantName;
  final String restuarantRate;
  final String restuarantReview;
  final String restaurantImage;

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  double selectedRating = 0;
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<ReviewsCubit>().getUserReviews();
    // });
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

      body: BlocListener<ReviewsCubit, ReviewsState>(
        listener: (context, state) {
          if (state is ReviewSuccess) {
            CustomSnackBar.show(
              context,
              message: "Review added successfuly",
              backgroundColor: AppColors.snackBarSuccessColor,
            );
            Navigator.pop(context);
          } else if (state is ReviewError) {
            CustomSnackBar.show(context, message: "${state.message}");
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        child: CachedNetworkImage(
                          imageUrl: widget.restaurantImage,

                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,

                          memCacheWidth: 600,
                          memCacheHeight: 400,

                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(color: Colors.white),
                          ),

                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.broken_image_rounded,
                              size: 40.sp,
                            ),
                          ),
                        ),
                      ),
                    ),

                    WidthSpace(width: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.restuarantName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff0F172A),
                          ),
                        ),

                        HeightSpace(height: 4),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),

                            WidthSpace(width: 4),

                            Text(
                              widget.restuarantRate,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            WidthSpace(width: 6),

                            Text(
                              '(${widget.restuarantReview} reviews)',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xff94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                HeightSpace(height: 24),

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
                        Center(
                          child: Text(
                            'How was your experience?',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: const Color(0xff94A3B8),
                            ),
                          ),
                        ),

                        HeightSpace(height: 12),

                        RatingWidget(
                          onChanged: (value) {
                            selectedRating = value;
                          },
                        ),

                        HeightSpace(height: 28),

                        HeightSpace(height: 20),

                        /// SHARE EXPERIENCE
                        Text(
                          "SHARE YOUR EXPERIENCE",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Poppins",
                            color: const Color(0xff94A3B8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        HeightSpace(height: 8),

                        CustomTextField(
                          controller: reviewController,
                          hintText:
                              "What did you love? How was the service and the atmosphere?",
                          maxLines: 9,
                          hintTextStyle: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xff94A3B8),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: Color(0xff94A3B8),
                          ),
                          fillColor: Color(0xffF8FAFC),
                          borderColor: Color(0xff94A3B8),
                          radius: 16,
                        ),

                        HeightSpace(height: 24),
                      ],
                    ),
                  ),
                ),
                HeightSpace(height: 20),
                Center(
                  child: SizedBox(
                    width: 300.w,
                    child: BlocBuilder<ReviewsCubit, ReviewsState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          onPressed: state is ReviewLoading
                              ? null
                              : () {
                                  if (reviewController.text.isNotEmpty) {
                                    context.read<ReviewsCubit>().addReview(
                                      restaurantId: widget.restuarantId,
                                      content: reviewController.text,
                                      rating: selectedRating,
                                      profileCubit: context
                                          .read<ProfileCubit>(),
                                    );
                                  }
                                },
                          child: state is ReviewLoading
                              ? const CircularProgressIndicator(
                                  color: AppColors.textWhiteColor,
                                )
                              : Text(
                                  "Post Review",
                                  style: TextStyle(
                                    color: AppColors.textWhiteColor,
                                    fontSize: 18.sp,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatefulWidget {
  final int starCount;
  final double initialRating;
  final void Function(double rating) onChanged;

  const RatingWidget({
    super.key,
    this.starCount = 5,
    this.initialRating = 0,
    required this.onChanged,
  });

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  void updateRating(double value) {
    setState(() {
      rating = value;
    });

    widget.onChanged(rating);
  }

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
          children: List.generate(widget.starCount, (index) {
            return GestureDetector(
              onTapDown: (details) {
                double dx = details.localPosition.dx;

                double newRating = dx < 20 ? index + 0.5 : index + 1;

                updateRating(newRating);
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
