import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/expolore_screen/presentation/cubit/explore_cubit.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/home_screen/presentation/cubit/home_state.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_assets/app_assets.dart';
import '../../../../core/constants/constant_data.dart';
import '../../../../core/models/restaurant_data_model.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_text_bottom.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/home_cubit.dart';
import 'widgets/custom_featured_restaurants_card.dart';
import 'widgets/custom_headline_text.dart';
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
            Stack(
              children: [
                //background image
                SizedBox(
                  width: 390.w,
                  height: 640.h,
                  child: Image.asset(AppAssets.homeImage, fit: BoxFit.fill),
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
                      CustomHeadlineText(
                        text: "Discover the best\nrestaurants in\nCairo",
                      ),
                      HeightSpace(height: 30),
                      //search field
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.primaryColor,
                                    content: Text(
                                      'Search field must not be empty',
                                    ),
                                  ),
                                );
                                return;
                              }
                              context.read<ExploreCubit>().setSearch(
                                searchController.text,
                              );
                              context.read<LayoutCubit>().changeTab(1);
                              FocusScope.of(context).unfocus();
                              searchController.clear();
                            },
                          ),
                        ],
                      ),
                      HeightSpace(height: 24),

                      //Buttons search and nearby
                    ],
                  ),
                ),
              ],
            ),
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
                  return SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: 288.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
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
                                RouteName.restaurantPageScreen,
                                extra: restaurant,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }

                return SizedBox(
                  height: 250.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48.sp,
                          color: AppColors.grayColor,
                        ),
                        HeightSpace(height: 8),
                        Text(
                          "No restaurants available",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Poppins',
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            HeightSpace(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Text(
                'Popular Cuisines',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color(0xff0F172A),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            HeightSpace(height: 16),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: isExpanded ? ConstantData.categories.length : 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  if (!isExpanded && index == 3) {
                    return _buildToggleItem(
                      icon: Icons.more_horiz,
                      label: "More",
                      onTap: () {
                        setState(() {
                          isExpanded = true;
                        });
                      },
                    );
                  }

                  if (isExpanded &&
                      index == ConstantData.categories.length - 1) {
                    return _buildToggleItem(
                      icon: Icons.expand_less,
                      label: "Less",
                      onTap: () {
                        setState(() {
                          isExpanded = false;
                        });
                      },
                    );
                  }

                  final cat = ConstantData.categories[index];

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<ExploreCubit>().setSearch(cat['title']);
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
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            HeightSpace(height: 26),
          ],
        ),
      ),
    );
  }
}

Widget _buildToggleItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 64.w,
          height: 64.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 30.sp),
        ),
        SizedBox(height: 8.h),
        Text(label),
      ],
    ),
  );
}
