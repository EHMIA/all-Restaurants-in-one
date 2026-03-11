import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/restaurant_page_screen/widgets/custom_res_menu_head_title.dart';
import 'package:resturant_project/restaurant_page_screen/widgets/custom_res_menu_appetizers_card.dart';

class CustomResMenuPage extends StatelessWidget {
  const CustomResMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomResMenuHeadTitle(
              title: 'Appetizers',
              appetizersItemsCount: 8,
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomResMenuAppetizersCard(
                  image: AppAssets.image,
                  title: 'Mix Grill',
                  description:
                      'Finely chopped parsley, tomatoes, mint, onion, soaked bulgur.',
                  price: '85 EGP',
                );
              },
            ),

            HeightSpace(height: 32),
            //Main Dishes
            CustomResMenuHeadTitle(
              title: 'Main Course',
              appetizersItemsCount: 12,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomResMenuAppetizersCard(
                  image: AppAssets.image,
                  title: 'Mix Grill',
                  description:
                      'Finely chopped parsley, tomatoes, mint, onion, soaked bulgur.',
                  price: '85 EGP',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
