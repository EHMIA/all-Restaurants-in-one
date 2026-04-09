import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/manager/favorite_repository.dart';
import 'package:resturant_project/features/favorite_screen/presentation/bloc/favorite_bloc.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_res_page_head.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_res_tab_bar_page.dart';

class RestaurantPageScreen extends StatelessWidget {
  const RestaurantPageScreen({
    super.key,
    this.image,
    this.resName,
    this.resRate,
    this.resPeopleRate,
    this.resSpace,
    this.category,
    this.isOpen,
  });
  final String? image;
  final String? resName;
  final String? resRate;
  final String? resPeopleRate;
  final String? resSpace;
  final String? category;
  final bool? isOpen;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteBloc>(
      create: (context) => FavoriteBloc(FavoriteRepository()),
      child: Scaffold(
        body: Column(
          children: [
            CustomResPageHead(
              resName: resName,
              image: image,
              resRate: resRate,
              numReviews: resPeopleRate,
              category: category,
              resSpace: resSpace,
              isOpen: isOpen,
            ),
            Expanded(
              child: CustomResTabBarPage(
                rate: resRate,
                numOfReviews: resPeopleRate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
