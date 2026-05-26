import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/profile_card.dart';
import '../../../data/model/user_model.dart';

class QuickLinksSection extends StatelessWidget {
  final User user;

  const QuickLinksSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              onTap: () =>
                  GoRouter.of(context).pushNamed(RouteName.myReviewPgeScreen),
              title: "My Reviews",
              subtitle: "${user.reviewsCount} published",
              icon: Icons.star_border,
              iconColor: Colors.orange,
              bgColor: const Color(0xFFFFF4E5),
            ),
            ProfileCard(
              onTap: () {
                GoRouter.of(context).pushNamed(RouteName.settingsScreen);
              },
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
      ],
    );
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
              if (dialogContext.mounted && context.mounted) {
                Navigator.pop(dialogContext);
                GoRouter.of(context).goNamed(RouteName.authRouteScreen);
              }
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
