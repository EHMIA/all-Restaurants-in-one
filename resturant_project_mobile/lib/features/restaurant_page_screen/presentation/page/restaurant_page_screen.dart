import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/manager/favorite_repository.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'package:resturant_project/core/repositories/restaurant_details_repo.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_page_cubit.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_page_head.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_tab_bar_page.dart';

class RestaurantPageScreen extends StatelessWidget {
  const RestaurantPageScreen({super.key, required this.restaurant});
  final RestaurantModel restaurant;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (context) => FavoriteCubit(FavoriteRepository()),
      child: Scaffold(
        body: Column(
          children: [
            CustomResPageHead(restaurant: restaurant),
            Expanded(
              child: BlocProvider(
                create: (context) => RestaurantPageCubit(repo: RestaurantDetailsRepo(api: DioConsumer(dio: Dio())))..getRestaurantsDetails(restaurant.id),
                child: CustomResTabBarPage(
                  id: restaurant.id,
                  rate: restaurant.rating.toString(),
                  numOfReviews: restaurant.reviewsCount.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
