import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit_state.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_button_res_page.dart';

class CustomResPageHead extends StatefulWidget {
  const CustomResPageHead({
    super.key,
    this.restaurant,
    this.image,
    this.numReviews,
    this.category,
    this.isOpen,
    this.resName,
    this.resRate,
    this.resSpace,
  });
  final RestaurantModel? restaurant;
  final String? image;
  final String? resName;
  final String? resRate;
  final String? numReviews;
  final String? resSpace;
  final String? category;
  final bool? isOpen;

  @override
  State<CustomResPageHead> createState() => _CustomResPageHeadState();
}

class _CustomResPageHeadState extends State<CustomResPageHead> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get display values from restaurant or legacy parameters
    final image =
        widget.restaurant?.coverPhoto ?? widget.image ?? AppAssets.image;
    final resName = widget.restaurant?.name ?? widget.resName ?? "Without Name";
    final resRate =
        widget.restaurant?.rating.toString() ?? widget.resRate ?? "0.0";
    final numReviews =
        widget.restaurant?.reviewsCount.toString() ?? widget.numReviews ?? "0";
    final isOpen = widget.restaurant?.isOpen ?? widget.isOpen ?? false;
    final cuisineTypes = widget.restaurant?.cuisineType ?? [];
    final category =
        (cuisineTypes.isNotEmpty ? cuisineTypes.first : null) ??
        widget.category ??
        "Unknown";
    final resSpace = widget.resSpace ?? "0 km";

    return SizedBox(
      height: 380.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Background Image
          Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(AppAssets.image, fit: BoxFit.cover);
            },
          ),

          /// Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),

          /// Top Buttons
          Positioned(
            top: 48.h,
            left: 16.w,
            child: CustomButtonResPage(
              onTap: () {
                GoRouter.of(context).pop();
              },
              icon: Icons.arrow_back,
            ),
          ),

          Positioned(
            top: 48.h,
            right: 16.w,
            child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
              builder: (context, state) {
                final isFavorite = widget.restaurant != null
                    ? state.favorites.any(
                        (element) => element.id == widget.restaurant!.id,
                      )
                    : state.favorites.any((element) => element.name == resName);

                return CustomButtonResPage(
                  onTap: () {
                    if (widget.restaurant != null) {
                      context.read<FavoriteCubit>().toggleFavoriteRestaurant(
                        widget.restaurant!,
                      );
                    }
                  },
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                );
              },
            ),
          ),

          /// Bottom Content
          Positioned(
            bottom: 24.h,
            left: 24.w,
            right: 24.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Open Now Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isOpen ? Color(0xff22C55E) : Color(0xff64748B),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    isOpen ? 'OPEN NOW' : 'CLOSED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                HeightSpace(height: 12),

                /// Title
                Text(
                  resName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                HeightSpace(height: 8.h),

                /// Rating Row
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.amber,
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),

                    Text(
                      resRate,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),

                    SizedBox(width: 6.w),

                    Text(
                      "($numReviews reviews)",
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),

                    SizedBox(width: 8.w),
                    Text("•", style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 8.w),

                    Text(
                      category,
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),

                    SizedBox(width: 8.w),
                    Text("•", style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 8.w),

                    Text(
                      resSpace,
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
