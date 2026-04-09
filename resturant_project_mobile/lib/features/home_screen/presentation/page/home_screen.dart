import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/constants/constant_data.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_text_bottom.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/home_screen/presentation/page/widgets/custom_featured_restaurants_card.dart';
import 'package:resturant_project/features/home_screen/presentation/page/widgets/custom_headline_text.dart';
import 'package:resturant_project/features/home_screen/presentation/page/widgets/search_text_field_widget.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SvgPicture.asset(AppAssets.logo),
            WidthSpace(width: 8),
            Text(
              "Akiel",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is FavoriteToggled) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Favorite updated')));
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Background image
                      SizedBox(
                        width: 390.w,
                        height: 640.h,
                        child: Image.asset(
                          AppAssets.homeImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeightSpace(height: 334),
                            const CustomHeadlineText(
                              text: "Discover the best\nrestaurants in\nCairo",
                            ),
                            HeightSpace(height: 30),
                            // Search field
                            Row(
                              children: [
                                Expanded(
                                  child: SearchTextFieldWidget(
                                    hintText: 'Search dishes...',
                                    controller: searchController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Search field must not be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                WidthSpace(width: 8),
                                CustomTextButton(
                                  isIcon: false,
                                  radius: 25.r,
                                  width: 85.w,
                                  text: 'Search',
                                  backgroundColor: AppColors.primaryColor,
                                  icon: CupertinoIcons.search,
                                  onTap: () {
                                    if (searchController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Search field must not be empty',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    context.read<HomeBloc>().add(
                                      SearchRestaurants(searchController.text),
                                    );
                                    context.read<LayoutCubit>().changeTab(1);
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ],
                            ),
                            HeightSpace(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(height: 32),
                  // Featured Restaurants Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured Restaurants',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xff0F172A),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<LayoutCubit>().changeTab(1);
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  HeightSpace(height: 16),
                  SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.featuredRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = state.featuredRestaurants[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: CustomFeaturedRestaurantsCard(
                            isFavorite: restaurant.isFavorite,
                            isOpen: restaurant.isOpen,
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                RouteName.restaurantPageScreen,
                                extra: {
                                  "image": restaurant.image,
                                  "resName": restaurant.name,
                                  "resPeopleRate": "4.5",
                                  "resRate": restaurant.rating.toString(),
                                  "resSpace": restaurant.distance,
                                  "category": restaurant.category,
                                  "isOpen": restaurant.isOpen,
                                },
                              );
                            },
                            titleText: restaurant.name,
                            image: restaurant.image,
                            restaurantRate: restaurant.rating.toString(),
                            spaceToRestaurant: restaurant.distance,
                            category: restaurant.category,
                            onFavoriteToggle: () {
                              context.read<HomeBloc>().add(
                                ToggleFavorite(restaurant.id),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  HeightSpace(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Text(
                      'Popular Cuisines',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: const Color(0xff0F172A),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  HeightSpace(height: 16),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ConstantData.categories.length,
                    itemBuilder: (context, index) {
                      final cat = ConstantData.categories[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<HomeBloc>().add(
                                FilterByCategory(cat['title']),
                              );
                              context.read<LayoutCubit>().changeTab(1);
                            },
                            child: Container(
                              width: 64.w,
                              height: 64.h,
                              decoration: BoxDecoration(
                                color: cat['color'],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                cat['icon'],
                                color: cat['iconColor'],
                                size: 30.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            cat['title'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  if (state.searchQuery != null ||
                      state.selectedCategory != null)
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search Results',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<HomeBloc>().add(ClearFilters());
                                  searchController.clear();
                                },
                                child: const Text('Clear'),
                              ),
                            ],
                          ),
                          ...state.filteredRestaurants.map(
                            (restaurant) => ListTile(
                              title: Text(restaurant.name),
                              subtitle: Text(restaurant.category),
                              trailing: Icon(
                                restaurant.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  HeightSpace(height: 26),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
