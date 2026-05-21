import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/expolore_screen/presentation/cubit/explore_cubit.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/home_screen/presentation/cubit/home_state.dart';
import 'package:resturant_project/features/home_screen/presentation/page/widgets/custom_home_hero_section.dart';
import 'package:resturant_project/features/home_screen/presentation/page/widgets/custom_popular_cuisines_widget.dart';
import 'package:resturant_project/features/home_screen/presentation/page/widgets/custom_restaurant_in_loading.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/models/restaurant_data_model.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_text_bottom.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/home_cubit.dart';
import 'widgets/custom_featured_restaurants_card.dart';
import 'widgets/custom_headline_text.dart';
import 'widgets/custom_restaurant_card_with_error.dart';
import 'widgets/search_text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHomeFeature();
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    //StorageHelper.removeToken();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHomeHeroSection(),
            HeightSpace(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Restaurants',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Color(0xff0F172A),
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
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const CustomRestaurantInLoading();
                }
                if (state is HomeSuccess) {
                  final List<RestaurantModel> restaurants = state.model.data;

                  return SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];

                        final bool isCurrentlyOpen = checkIfRestaurantOpen(
                          restaurant.openingHours,
                        );

                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: CustomFeaturedRestaurantsCard(
                            isFavorite: restaurant.isFavorite,
                            isOpen: isCurrentlyOpen,
                            titleText: restaurant.name,
                            image: restaurant.coverPhoto.url,
                            restaurantRate: restaurant.rating.toString(),
                            categories: restaurant.cuisineType.isNotEmpty
                                ? restaurant.cuisineType
                                : ['No Category'],
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                RouteName.restaurantScreen,
                                extra: restaurant,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }

                return const CustomRestaurantCardWithError();
              },
            ),
            HeightSpace(height: 40),
            CustomPopularCuisinesWidget(),
            HeightSpace(height: 26),
          ],
        ),
      ),
    );
  }
}
