import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/profile_cubit.dart';

import '../../../data/model/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
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

            // Profile picture
            Container(
              height: 130.h,
              width: 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200.r),
                child: user.profilePic != null && user.profilePic!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: user.profilePic!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        memCacheWidth: 600,
                        memCacheHeight: 400,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade200,
                          child: Icon(Icons.broken_image_rounded, size: 40.sp),
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
                Icon(Icons.phone, size: 20.sp, color: AppColors.grayColor),
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
                Icon(Icons.email, size: 20.sp, color: AppColors.grayColor),
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

            // Joined date
            Text(
              'Joined ${_formatDate(user.createdAt)}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: AppColors.grayColor,
              ),
            ),
            HeightSpace(height: 16),

            // Favorites & Reviews pill
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
                ).pushNamed(RouteName.editProfileScreen);
                if (result == true && context.mounted) {
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
}
