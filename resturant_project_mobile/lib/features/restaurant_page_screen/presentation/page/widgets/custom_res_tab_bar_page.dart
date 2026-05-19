import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'package:resturant_project/core/repositories/restaurant_data_repo.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_main_data_cubit.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_info_page.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_menu_page.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_photo_page.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_reviews_page.dart';

class CustomResTabBarPage extends StatelessWidget {
  const CustomResTabBarPage({
    super.key,
    this.rate,
    this.numOfReviews,
    required this.id,
    this.name,
    required this.image,
    required this.restaurant,
  });
  final String? rate;
  final String? numOfReviews;
  final String id;
  final String? name;
  final String image;
  final RestaurantModel restaurant;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantMainDataCubit(
        repo: RestaurantDataRepo(api: DioConsumer(dio: Dio())),
      )..getRestaurantsMainData(restaurant.id),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
            indicatorWeight: 4,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.primaryColor,
            height: 54.h,
            indicatorColor: AppColors.primaryColor,
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.grayColor,
            ),
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          tabs: [Text('Menu'), Text('Photos'), Text('Reviews'), Text('Info')],
          views: [
            CustomResMenuPage(restaurantId: id),
            CustomResPhotoPage(restaurantId: id),
            CustomResReviewsPage(
              rate: rate,
              numOfReviews: numOfReviews,
              name: name,
              id: id,
              image: image,
            ),
            CustomResInfoPage(restaurant: restaurant),
          ],
        ),
      ),
    );
  }
}
