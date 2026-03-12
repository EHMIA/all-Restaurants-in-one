import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/manager/favorite_manager.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/expolore_screen/widgets/custom_list_cards.dart';
import 'package:resturant_project/features/favorite_screen/favorite_empty_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  // ✅ Public state so LayoutScreen can access it via GlobalKey
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> get favoriteRestaurants =>
      FavoriteManager.favorites;

  final Set<int> _pendingRemoval = {};

  /// Called by LayoutScreen when the user navigates away from this tab
  void applyPendingRemovals() {
    if (_pendingRemoval.isEmpty) return;
    setState(() {
      final toRemove = _pendingRemoval.toList()..sort((a, b) => b.compareTo(a));
      for (final index in toRemove) {
        favoriteRestaurants.removeAt(index);
      }
      _pendingRemoval.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favorites",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list, color: AppColors.primaryColor),
          ),
          WidthSpace(width: 16),
        ],
      ),
      body: favoriteRestaurants.isEmpty
          ? FavoriteEmptyScreen()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 128.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffFAFAFA), Color(0xffFFFDE7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Favorites",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 31.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                constraints: BoxConstraints(minWidth: 107.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: Color(
                                    0xffE23744,
                                  ).withValues(alpha: 0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${favoriteRestaurants.length} restaurants",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: "Poppins",
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          HeightSpace(height: 8),
                          Text(
                            "All the restaurants you loved and saved.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                              color: Color(0xff475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: favoriteRestaurants.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.h,
                        crossAxisSpacing: 8.w,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final isPendingRemoval = _pendingRemoval.contains(
                          index,
                        );

                        return CustomListCards(
                          onFavoriteToggle: () {
                            setState(() {
                              if (isPendingRemoval) {
                                _pendingRemoval.remove(index);
                              } else {
                                _pendingRemoval.add(index);
                              }
                            });
                          },
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              RouteName.restaurantPageScreen,
                              extra: {
                                "image": favoriteRestaurants[index]['image'],
                                "resName": favoriteRestaurants[index]['resName'],
                                "resPeopleRate":
                                    favoriteRestaurants[index]['resPeopleRate'],
                                "resRate": favoriteRestaurants[index]['resRate'],
                                "resSpace": favoriteRestaurants[index]['resSpace'],
                              },
                            );
                          },
                          isFavorite: !isPendingRemoval,
                          image: favoriteRestaurants[index]['image'],
                          resName: favoriteRestaurants[index]['resName'],
                          numReviews:
                              favoriteRestaurants[index]['resPeopleRate'],
                          resRate: favoriteRestaurants[index]['resRate'],
                          resSpace: favoriteRestaurants[index]['resSpace'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
