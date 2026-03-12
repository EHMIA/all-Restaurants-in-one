import 'package:flutter/material.dart';
import 'package:resturant_project/features/core/widgets/custom_bottom_nav_bar.dart';
import 'package:resturant_project/features/expolore_screen/explore_screen.dart';
import 'package:resturant_project/features/favorite_screen/favorite_screen.dart';
import 'package:resturant_project/features/home_screen/home_screen.dart';
import 'package:resturant_project/features/profile_screen/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  // ✅ GlobalKey to access FavoriteScreen's public state
  final GlobalKey<FavoriteScreenState> _favoriteKey =
      GlobalKey<FavoriteScreenState>();

  // ✅ Favorites tab index — update this if your tab order changes
  static const int _favoritesTabIndex = 2;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      const ExploreScreen(),
      FavoriteScreen(key: _favoriteKey), // ✅ attach key here
      const ProfileScreen(),
    ];
  }

  void changeTab(int index) {
    // ✅ If leaving the favorites tab, apply pending removals immediately
    if (currentIndex == _favoritesTabIndex && index != _favoritesTabIndex) {
      _favoriteKey.currentState?.applyPendingRemovals();
    }

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: changeTab,
      ),
    );
  }
}
