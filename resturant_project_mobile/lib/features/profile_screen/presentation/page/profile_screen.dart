import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:resturant_project/features/profile_screen/data/repository/profile_repo.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/profile_cubit.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/info_tile.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/profile_card.dart';
import 'package:resturant_project/features/review_page/data/repository/reviews_repo.dart';
import 'package:resturant_project/features/review_page/presentation/cubit/reviews_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/model/user_model.dart';
import '../cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, String> _userData = {};
  String? _profileImagePath;

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
    final imagePath = await StorageHelper.getProfileImagePath();
    if (mounted) {
      setState(() {
        _userData = data;
        _profileImagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        repo: UserRepo(api: DioConsumer(dio: Dio())),
      )..getProfile(),
      child: BlocProvider(
        create: (context) => ReviewsCubit(
          repo: ReviewRepo(api: DioConsumer(dio: Dio())),
        )..getUserReviews(),
        child: const _ProfileView(),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileFailure) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileSuccess) {
            final user = state.userModel.user;
            return _buildBody(context, user);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, User user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Header section ──────────────────────────────────────────
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
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

                  // Profile picture (network or placeholder)
                  Container(
                    height: 130.h,
                    width: 130.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200.r),
                      child:
                          user.profilePic != null && user.profilePic!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: user.profilePic ?? AppAssets.homeImage,

                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,

                              memCacheWidth: 600,
                              memCacheHeight: 400,

                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(color: Colors.white),
                              ),

                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey.shade200,
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  size: 40.sp,
                                ),
                              ),
                            )
                          : Image.asset(AppAssets.profile, fit: BoxFit.cover),
                    ),
                  ),
                  HeightSpace(height: 24),

                  Text(
                    user.fullname,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Phone
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
                        user.phone,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ],
                  ),

                  // Email
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
                        user.email,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ],
                  ),

                  // Joined date  (format createdAt properly)
                  Text(
                    'Joined ${_formatDate(user.createdAt)}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: AppColors.grayColor,
                    ),
                  ),
                  HeightSpace(height: 16),

                  // Favorites & Reviews pill — now from the API model directly
                  Container(
                    height: 38.h,
                    width: 244.w,
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
                        Text(
                          '${user.favoritesCount} Favorites',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff212121),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
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
                        Text(
                          '${user.reviewsCount} Reviews',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff212121),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  HeightSpace(height: 24),

                  // Edit Profile button
                  GestureDetector(
                    onTap: () async {
                      final result = await GoRouter.of(
                        context,
                      ).pushNamed(RouteName.editProfilePage);
                      if (result == true) {
                        // Re-fetch from API after editing
                        context.read<ProfileCubit>().getProfile();
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

          // ── Personal Information section ─────────────────────────────
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
                      InfoTile(label: "FULL NAME", value: user.fullname),
                      const Divider(height: 1, thickness: 0.5),
                      InfoTile(label: "EMAIL ADDRESS", value: user.email),
                      const Divider(height: 1, thickness: 0.5),
                      InfoTile(label: "PHONE NUMBER", value: user.phone),
                      const Divider(height: 1, thickness: 0.5),
                      InfoTile(label: "ADDRESS", value: user.address.details),
                    ],
                  ),
                ),
                HeightSpace(height: 24),

                // ── Quick Links ─────────────────────────────────────────
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
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileCard(
                      onTap: () => context.read<LayoutCubit>().changeTab(2),
                      title: "My Favorites",
                      subtitle: "${user.favoritesCount} saved items",
                      icon: Icons.favorite_border,
                      iconColor: Colors.red,
                      bgColor: const Color(0xFFFDECEC),
                    ),
                    ProfileCard(
                      onTap: () => GoRouter.of(
                        context,
                      ).pushNamed(RouteName.myReviewPgeScreen),
                      title: "My Reviews",
                      subtitle: "${user.reviewsCount} published",
                      icon: Icons.star_border,
                      iconColor: Colors.orange,
                      bgColor: const Color(0xFFFFF4E5),
                    ),
                    ProfileCard(
                      onTap: () {},
                      title: "Settings",
                      subtitle: "Security, privacy",
                      icon: Icons.settings,
                      iconColor: Colors.grey,
                      bgColor: const Color(0xFFF0F2F5),
                    ),
                    ProfileCard(
                      title: "Logout",
                      subtitle: "Sign out",
                      icon: Icons.logout,
                      iconColor: Colors.red,
                      bgColor: const Color(0xFFFDECEC),
                      isLogout: true,
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
                HeightSpace(height: 94),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _showLogoutDialog(BuildContext context) {
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
            color: const Color(0xff94A3B8),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
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
              GoRouter.of(context).goNamed(RouteName.authRouteScreen);
            },
            child: const Text(
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
  }
}
