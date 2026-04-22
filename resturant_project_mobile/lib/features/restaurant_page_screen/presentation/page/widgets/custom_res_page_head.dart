import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit_state.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_button_res_page.dart';
import 'package:shimmer/shimmer.dart';

class CustomResPageHead extends StatelessWidget {
  const CustomResPageHead({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    String getPriceSymbol(String priceRange) {
  switch (priceRange.toLowerCase()) {
    case 'low':
      return r'$';
    case 'medium':
      return r'$•$';
    case 'high':
      return r'$•$•$';
    default:
      return r'$';
  }
}
    return SizedBox(
      height: 380.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            restaurant.coverPhoto.url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Image.asset(AppAssets.image, fit: BoxFit.cover);
            },
          ),
          CachedNetworkImage(
            imageUrl: restaurant.coverPhoto.url,
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
              child: Icon(Icons.broken_image_rounded, size: 40.sp),
            ),
          ),
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

          /// Back Button
          Positioned(
            top: 48.h,
            left: 16.w,
            child: CustomButtonResPage(
              onTap: () => GoRouter.of(context).pop(),
              icon: Icons.arrow_back,
            ),
          ),

          /// Favorite Button
          Positioned(
            top: 48.h,
            right: 16.w,
            child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
              builder: (context, state) {
                final isFavorite = state.favorites.any(
                  (e) => e.id == restaurant.id,
                );

                return CustomButtonResPage(
                  onTap: () {
                    context.read<FavoriteCubit>().toggleFavoriteRestaurant(
                      restaurant,
                    );
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: restaurant.isOpen
                        ? const Color(0xff22C55E)
                        : const Color(0xff64748B),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    restaurant.isOpen ? 'OPEN NOW' : 'CLOSED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                HeightSpace(height: 12),

                /// Name
                Text(
                  restaurant.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                HeightSpace(height: 8),

                /// Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          restaurant.rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "•",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.sp,
                          ),
                        ),
                        WidthSpace(width: 8),
                        Text(
                          "( ${restaurant.reviewsCount} reviews )",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                    Text(
                      getPriceSymbol(restaurant.priceRange),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),

                HeightSpace(height: 8),

                /// Categories
                SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.cuisineType.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Text(
                          restaurant.cuisineType[index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
