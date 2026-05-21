import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_assets/app_assets.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/custom_text_bottom.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../../../bottom_navigation_bar/cubit/layout_cubit.dart';
import '../../../../expolore_screen/presentation/cubit/explore_cubit.dart';
import 'custom_headline_text.dart';
import 'search_text_field_widget.dart';

class CustomHomeHeroSection extends StatefulWidget {
  const CustomHomeHeroSection({super.key});

  @override
  State<CustomHomeHeroSection> createState() => _CustomHomeHeroSectionState();
}

class _CustomHomeHeroSectionState extends State<CustomHomeHeroSection> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        SizedBox(
          width: 390.w,
          height: 640.h,
          child: Image.asset(AppAssets.homeImage, fit: BoxFit.fill),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(height: 334),
              const CustomHeadlineText(
                text: "Discover the best\nrestaurants in\nCairo",
              ),
              HeightSpace(height: 30),
              // Search field
              Row(
                children: [
                  Expanded(
                    child: SearchTextFieldWidget(
                      hintText: 'Search dishes...',
                      controller: searchController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Search field must not be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  WidthSpace(width: 8),
                  CustomTextButton(
                    isIcon: false,
                    radius: 25.r,
                    width: 85.w,
                    text: 'Search',
                    backgroundColor: AppColors.primaryColor,
                    icon: CupertinoIcons.search,
                    onTap: () {
                      if (searchController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.primaryColor,
                            content: Text('Search field must not be empty'),
                          ),
                        );
                        return;
                      }
                      context.read<ExploreCubit>().setSearch(
                        searchController.text,
                      );
                      context.read<LayoutCubit>().changeTab(1);
                      FocusScope.of(context).unfocus();
                      searchController.clear();
                    },
                  ),
                ],
              ),
              HeightSpace(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
