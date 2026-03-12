import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/profile_screen/widgets/info_tile.dart';
import 'package:resturant_project/features/profile_screen/widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        actions: [
          IconButton(
            onPressed: () {
              print('clicked');
            },
            icon: Icon(Icons.edit_outlined, color: AppColors.primaryColor),
          ),
          WidthSpace(width: 16),
        ],
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
                      'Akiel',
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
                          'akiel.food.@example.com',
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
                          Text(
                            '12 Favorites',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xff212121),
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
                            '8 Reviews',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xff212121),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    HeightSpace(height: 24),
                    GestureDetector(
                      onTap: () {},
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
                    HeightSpace(height: 12),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(RouteName.settingsPage);
                      },
                      child: Container(
                        width: 342.w,
                        height: 56.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
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
                        InfoTile(label: "FULL NAME", value: "Akiel Montgomery"),
                        Divider(height: 1, thickness: 0.5),

                        InfoTile(
                          label: "EMAIL ADDRESS",
                          value: "akiel.foodie@example.com",
                          onTap: () {},
                        ),
                        Divider(height: 1, thickness: 0.5),

                        InfoTile(
                          label: "PHONE NUMBER",
                          value: "+1 (234) 567 890",
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
                      ProfileCard(
                        title: "My Favorites",
                        subtitle: "12 saved items",
                        icon: Icons.favorite_border,
                        iconColor: Colors.red,
                        bgColor: Color(0xFFFDECEC),
                      ),
                      ProfileCard(
                        onTap: () {
                          GoRouter.of(
                            context,
                          ).pushNamed(RouteName.myReviewPgeScreen);
                        },
                        title: "My Reviews",
                        subtitle: "8 published",
                        icon: Icons.star_border,
                        iconColor: Colors.orange,
                        bgColor: Color(0xFFFFF4E5),
                      ),
                      ProfileCard(
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
    );
  }
}
