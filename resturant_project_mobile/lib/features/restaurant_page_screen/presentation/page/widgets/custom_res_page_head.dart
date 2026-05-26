import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'package:resturant_project/core/repositories/restaurant_data_repo.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_state.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_main_data_cubit.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_main_data_state.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_button_res_page.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/restaurant_head_shimmer_loading.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../profile_screen/presentation/cubit/profile_cubit.dart';

class CustomResPageHead extends StatelessWidget {
  const CustomResPageHead({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantMainDataCubit(
        repo: RestaurantDataRepo(api: DioConsumer(dio: Dio())),
      )..getRestaurantsMainData(restaurant.id),
      child: BlocBuilder<RestaurantMainDataCubit, RestaurantMainDataState>(
        builder: (context, state) {
          Widget currentWidget;

          if (state is RestaurantMainDataLoading) {
            currentWidget = const RestaurantHeadShimmerLoading(
              key: ValueKey('loading_head'),
            );
          } else if (state is RestaurantMainDataError) {
            currentWidget = _buildHeadContent(
              context, 
              restaurant, 
              key: const ValueKey('error_head'),
            );
          } else if (state is RestaurantMainDataSuccess) {
            final loadedRestaurant = state.restaurant.data.isNotEmpty
                ? state.restaurant.data.first
                : restaurant;
            currentWidget = _buildHeadContent(
              context, 
              loadedRestaurant, 
              key: const ValueKey('success_head'),
            );
          } else {
            currentWidget = _buildHeadContent(
              context, 
              restaurant, 
              key: const ValueKey('default_head'),
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 600), 
            switchInCurve: Curves.easeIn,                
            switchOutCurve: Curves.easeOut,              
            child: currentWidget,
          );
        },
      ),
    );
  }

  Widget _buildHeadContent(
    BuildContext context,
    RestaurantModel restaurantData, {
    Key? key,
  }) {
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
      key: key, 
      height: 380.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: restaurantData.coverPhoto.url,
            fit: BoxFit.cover,
            memCacheWidth: 600,
            memCacheHeight: 400,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, error) {
              return Image.asset(AppAssets.image, fit: BoxFit.cover);
            },
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

          Positioned(
            top: 48.h,
            left: 16.w,
            child: CustomButtonResPage(
              onTap: () => GoRouter.of(context).pop(),
              icon: Icons.arrow_back,
            ),
          ),

          Positioned(
            top: 48.h,
            right: 16.w,
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                final cubit = context.read<FavoriteCubit>();
                final isFav = cubit.isFavorite(restaurantData.id);

                return CustomButtonResPage(
                  onTap: () {
                    if (isFav) {
                      cubit.removeCardFromFav(restaurantData.id,
                        context.read<ProfileCubit>(),
                      );
                    } else {
                      cubit.addResToFavorites(restaurantData.id,
                        context.read<ProfileCubit>(),
                      );
                    }
                  },
                  icon: isFav ? Icons.favorite : Icons.favorite_border,
                );
              },
            ),
          ),

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
                    color: restaurantData.isOpen
                        ? const Color(0xff22C55E)
                        : const Color(0xff64748B),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    restaurantData.isOpen ? 'OPEN NOW' : 'CLOSED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                HeightSpace(height: 12),

                Text(
                  restaurantData.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                HeightSpace(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 6.w),
                        Text(
                          restaurantData.rating.toString(),
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
                          "( ${restaurantData.reviewsCount} reviews )",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                    Text(
                      getPriceSymbol(restaurantData.priceRange),
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

                SizedBox(
                  height: 20.h,
                  child: restaurantData.cuisineType.isEmpty
                      ? const SizedBox()
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurantData.cuisineType.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Text(
                                restaurantData.cuisineType[index],
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