import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/repositories/restaurant_data_repo.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/bottom_navigation_bar/page/custom_bottom_nav_bar.dart';
import 'package:resturant_project/features/expolore_screen/presentation/cubit/explore_cubit.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/explore_screen.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'package:resturant_project/features/favorite_screen/presentation/page/favorite_screen.dart';
import 'package:resturant_project/features/home_screen/presentation/cubit/home_cubit.dart';
import '../../home_screen/presentation/page/home_screen.dart';
import '../../profile_screen/presentation/page/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const ExploreScreen(),
      const FavoriteScreen(),
      const ProfileScreen(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            repo: RestaurantDataRepo(api: DioConsumer(dio: Dio())),
          ),
        ),
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(
          create: (context) => ExploreCubit(
            repo: RestaurantDataRepo(api: DioConsumer(dio: Dio())),
          ),
        ),
      ],
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(index: currentIndex, children: screens),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<LayoutCubit>().changeTab(index);
                if (currentIndex == 1 && index != 1) {
                  context.read<ExploreCubit>().resetFilters();
                }
                if (currentIndex == 2) {
                  context.read<FavoriteCubit>().getAllFavoriteRestaurant();
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
