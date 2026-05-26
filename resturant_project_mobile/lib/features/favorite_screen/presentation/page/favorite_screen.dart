import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/custom_list_cards.dart';
import 'package:resturant_project/features/favorite_screen/presentation/page/widgets/custom_favorite_header.dart';
import 'package:resturant_project/features/favorite_screen/presentation/page/widgets/favorite_empty_screen.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_state.dart';

import '../../../profile_screen/presentation/cubit/profile_cubit.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().getAllFavoriteRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favorites",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading || state is FavoriteInitial) {
            return Scaffold(
              backgroundColor: AppColors.backgroundWhiteColor,
              body: const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          }

          if (state is FavoriteError) {
            return const FavoriteEmptyScreen();
          }

          if (state is FavoriteSuccess) {
            if (state.favorites.isEmpty) {
              return const FavoriteEmptyScreen();
            }

            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFavoriteHeader(
                      favoritesCount: state.favorites.length,
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.favorites.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.h,
                          crossAxisSpacing: 16.w,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final item = state.favorites[index];
                          final restaurant = item.restaurant;

                          return CustomListCards(
                            haveReview: false,
                            onFavoriteToggle: () {
                              context.read<FavoriteCubit>().removeCardFromFav(
                                restaurant.id,
                                context.read<ProfileCubit>(),
                              );
                            },
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                RouteName.restaurantScreen,
                                extra: restaurant.toRestaurantModel(),
                              );
                            },
                            isFavorite: true,
                            image: restaurant.coverPhoto.url,
                            resName: restaurant.name,
                            numReviews: restaurant.reviewsCount.toString(),
                            resRate: restaurant.rating.toString(),
                            categories: restaurant.cuisineType,
                            isOpen: restaurant.isOpen,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
