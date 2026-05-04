import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/info_tile.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/profile_card.dart';
import 'package:resturant_project/features/review_page/data/repository/reviews_repo.dart';
import 'package:resturant_project/features/review_page/presentation/cubit/reviews_cubit.dart';

import '../../../favorite_screen/presentation/cubit/favorite_state.dart';
import '../../../review_page/presentation/cubit/reviews_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Map<String, String> _userData = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    final data = await StorageHelper.getUserData();
    if (mounted) {
      setState(() => _userData = data);
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsCubit(
        repo: ReviewRepo(api: DioConsumer(dio: Dio())),
      )..getUserReviews(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Profile",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFFF8F0), Color(0xffFFF0F1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      HeightSpace(height: 44),
                      Container(
                        height: 130.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200.r),
                          child: Image.asset(
                            AppAssets.profile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      HeightSpace(height: 24),
                      Text(
                        _userData['name'] ?? 'User',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            size: 20.sp,
                            color: AppColors.grayColor,
                          ),
                          WidthSpace(width: 5),
                          Text(
                            '+1234567890',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.sp,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            size: 20.sp,
                            color: AppColors.grayColor,
                          ),
                          WidthSpace(width: 5),
                          Text(
                            _userData['email'] ?? '',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.sp,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Joined January 2026',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          color: AppColors.grayColor,
                        ),
                      ),
                      HeightSpace(height: 16),
                      Container(
                        height: 38.h,
                        width: 244.w,
                        //constraints: BoxConstraints(minWidth: 244.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.heart,
                              size: 15.sp,
                              color: AppColors.primaryColor,
                            ),
                            WidthSpace(width: 5),
                            BlocBuilder<FavoriteCubit, FavoriteState>(
                              builder: (context, state) {
                                if (state is FavoriteSuccess) {
                                  return Text(
                                    '${state.favorites.length} Favorites',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff212121),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                return Text(
                                  'No Favorites',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff212121),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            WidthSpace(width: 8),
                            Text(
                              '•',
                              style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize: 15.sp,
                              ),
                            ),
                            WidthSpace(width: 8),
                            Icon(
                              CupertinoIcons.star,
                              size: 15.sp,
                              color: Colors.amberAccent,
                            ),

                            WidthSpace(width: 5),
                            BlocBuilder<ReviewsCubit, ReviewsState>(
                              builder: (context, state) {
                                if (state is ReviewSuccess) {
                                  return Text(
                                    '${state.review.length} Reveiws',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xff212121),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                return Text(
                                  'No Reviews',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff212121),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      HeightSpace(height: 24),
                      GestureDetector(
                        onTap: () async {
                          final result = await GoRouter.of(context).pushNamed(RouteName.editProfilePage);
                          // Refresh profile data after returning from edit screen
                          if (result == true) {
                            _loadData();
                          }
                        },
                        child: Container(
                          width: 342.w,
                          height: 56.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      HeightSpace(height: 40),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(height: 24),
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    HeightSpace(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InfoTile(
                            label: "FULL NAME",
                            value: _userData['name'] ?? '',
                          ),
                          Divider(height: 1, thickness: 0.5),

                          InfoTile(
                            label: "EMAIL ADDRESS",
                            value: _userData['email'] ?? '',
                            onTap: () {},
                          ),
                          Divider(height: 1, thickness: 0.5),

                          InfoTile(
                            label: "PHONE NUMBER",
                            value: _userData['phone'] ?? '',
                            onTap: () {},
                          ),
                          Divider(height: 1, thickness: 0.5),

                          InfoTile(
                            label: "PREFERRED CITY",
                            value: "New York City, NY",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    HeightSpace(height: 24),
                    Text(
                      'Quick Links',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    HeightSpace(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.05,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, state) {
                            if (state is FavoriteSuccess) {
                              return ProfileCard(
                                onTap: () {
                                  context.read<LayoutCubit>().changeTab(2);
                                },
                                title: "My Favorites",
                                subtitle:
                                    "${state.favorites.length} saved items",
                                icon: Icons.favorite_border,
                                iconColor: Colors.red,
                                bgColor: Color(0xFFFDECEC),
                              );
                            }
                            return ProfileCard(
                              onTap: () {
                                context.read<LayoutCubit>().changeTab(2);
                              },
                              title: "My Favorites",
                              subtitle: "No saved items",
                              icon: Icons.favorite_border,
                              iconColor: Colors.red,
                              bgColor: Color(0xFFFDECEC),
                            );
                          },
                        ),
                        BlocBuilder<ReviewsCubit, ReviewsState>(
                          builder: (context, state) {
                            if (state is ReviewSuccess) {
                              return ProfileCard(
                                onTap: () {
                                  GoRouter.of(
                                    context,
                                  ).pushNamed(RouteName.myReviewPgeScreen);
                                },
                                title: "My Reviews",
                                subtitle: "${state.review.length} published",
                                icon: Icons.star_border,
                                iconColor: Colors.orange,
                                bgColor: Color(0xFFFFF4E5),
                              );
                            }
                            return ProfileCard(
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).pushNamed(RouteName.myReviewPgeScreen);
                              },
                              title: "My Reviews",
                              subtitle: "0 published",
                              icon: Icons.star_border,
                              iconColor: Colors.orange,
                              bgColor: Color(0xFFFFF4E5),
                            );
                          },
                        ),
                        ProfileCard(
                          onTap: () {},
                          title: "Settings",
                          subtitle: "Security, privacy",
                          icon: Icons.settings,
                          iconColor: Colors.grey,
                          bgColor: Color(0xFFF0F2F5),
                        ),
                        ProfileCard(
                          title: "Logout",
                          subtitle: "Sign out",
                          icon: Icons.logout,
                          iconColor: Colors.red,
                          bgColor: Color(0xFFFDECEC),
                          isLogout: true,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: Center(
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                                content: Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    color: Color(0xff94A3B8),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await StorageHelper.removeToken();

                                      Navigator.pop(dialogContext);

                                      GoRouter.of(
                                        context,
                                      ).goNamed(RouteName.authRouteScreen);
                                    },
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    HeightSpace(height: 94),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
