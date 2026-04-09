import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/bottom_navigation_bar/page/custom_bottom_nav_bar.dart';
import 'package:resturant_project/core/manager/favorite_repository.dart';
import 'package:resturant_project/features/expolore_screen/presentation/bloc/explore_cubit.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/explore_screen.dart';
import 'package:resturant_project/features/favorite_screen/presentation/bloc/favorite_bloc.dart';
import 'package:resturant_project/features/favorite_screen/presentation/page/favorite_screen.dart';
import 'package:resturant_project/features/profile_screen/profile_screen.dart';

import '../../home_screen/presentation/page/home_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

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
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => ExploreCubit()),
        BlocProvider(create: (_) => FavoriteBloc(FavoriteRepository())),      ],
      child: BlocBuilder<LayoutCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(index: currentIndex, children: screens),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<LayoutCubit>().changeTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}
