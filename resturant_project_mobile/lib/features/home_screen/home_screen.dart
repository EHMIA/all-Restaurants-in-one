import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/constants/constant_data.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/core/widgets/custom_category_item.dart';
import 'package:resturant_project/features/home_screen/widgets/custom_featured_restaurants_card.dart';
import 'package:resturant_project/features/home_screen/widgets/custom_headline_text.dart';
import 'package:resturant_project/features/home_screen/widgets/search_text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isSelectedIndex = 0;
  bool isExpanded = false;
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
                      //search field
                      SearchTextFieldWidget(
                        hintText: 'Search dishes...',
                        controller: searchController,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (searchController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primaryColor,
                                content: Text('Search field must not be empty'),
                              ),
                            );
                            return;
                          }
                          await GoRouter.of(context).pushNamed(
                            RouteName.explorScreen,
                            extra: searchController.text,
                          );
                        },
                      ),
                      HeightSpace(height: 24),
                      //Buttons search and nearby
                      // CustomButtonHome(
                      //   width: double.infinity,
                      //   text: 'Search',
                      //   color: AppColors.primaryColor, //Color(0xffFF6D00),
                      //   icon: CupertinoIcons.search,
                      //   onTap: () {
                      //     if (searchController.text.isEmpty) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           backgroundColor: AppColors.primaryColor,
                      //           content: Text('Search field must not be empty'),
                      //         ),
                      //       );
                      //       return;
                      //     }
                      //     GoRouter.of(context).pushNamed(
                      //       RouteName.explorScreen,
                      //       extra: searchController.text,
                      //     );
                      //     FocusScope.of(context).unfocus();
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            //HeightSpace(height: 24),

            // SizedBox(
            //   height: 50.h,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     physics: BouncingScrollPhysics(),
            //     itemCount: ConstantData.category.length,
            //     itemBuilder: (context, index) {
            //       return CustomCategoryItemWidget(
            //         isSelected: isSelectedIndex == index,
            //         title: ConstantData.category[index]['title'],
            //         icon: ConstantData.category[index]['icon'],

            //         onTap: () {
            //           setState(() {
            //             isSelectedIndex = index;
            //             GoRouter.of(context).pushNamed(
            //               RouteName.explorScreen,
            //               extra: {
            //                 "search": searchController.text,
            //                 "category": ConstantData.category[index]['title'],
            //               },
            //             );
            //           });
            //         },
            //       );
            //     },
            //   ),
            // ),
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
                      GoRouter.of(context).pushNamed(RouteName.explorScreen);
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

                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: CustomFeaturedRestaurantsCard(
                      isFavorite: true,
                      isOpen: ConstantData.restaurants[index]['isOpen'],
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                          RouteName.restaurantPageScreen,
                          extra: {
                            "image": ConstantData.restaurants[index]['image'],
                            "resName":
                                ConstantData.restaurants[index]['resName'],
                            "resPeopleRate": ConstantData
                                .restaurants[index]['resPeopleRate'],
                            "resRate":
                                ConstantData.restaurants[index]['resRate'],
                            "resSpace":
                                ConstantData.restaurants[index]['resSpace'],
                            "category":
                                ConstantData.restaurants[index]['category'],
                            "isOpen": ConstantData.restaurants[index]['isOpen'],
                          },
                        );
                      },
                      titleText: ConstantData.restaurants[index]['resName'],
                      image: ConstantData.restaurants[index]['image'],
                      restaurantRate:
                          ConstantData.restaurants[index]['resRate'],
                      spaceToRestaurant:
                          ConstantData.restaurants[index]['resSpace'],
                      category: ConstantData.restaurants[index]['category'],
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
                  color: Color(0xff0F172A),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            HeightSpace(height: 16),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ConstantData.categories.length,
              itemBuilder: (context, index) {
                final cat = ConstantData.categories[index];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                          RouteName.explorScreen,
                          extra: cat['title'],
                        );
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
                      style: TextStyle(fontSize: 12.sp, fontFamily: 'Poppins'),
                    ),
                  ],
                );
              },
            ),
            HeightSpace(height: 26),
          ],
        ),
      ),
    );
  }
}
