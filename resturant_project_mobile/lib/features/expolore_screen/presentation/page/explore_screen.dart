import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/constants/constant_data.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_bottom.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/expolore_screen/presentation/bloc/explore_cubit.dart';
import 'package:resturant_project/features/expolore_screen/presentation/bloc/explore_state.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/custom_list_cards.dart';
import 'package:resturant_project/features/core/widgets/custom_category_item.dart';
import 'package:resturant_project/features/home_screen/widgets/search_text_field_widget.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/filter_icon_button.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/filter_bottom_sheet.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/active_filter_chip.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/explore_empty_state.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key, this.searchText, this.category});
  final String? searchText;
  final String? category;

  @override
  Widget build(BuildContext context) {
    // Initialize cubit with search text and category if provided
    final cubit = context.read<ExploreCubit>();
    if (searchText != null && searchText!.isNotEmpty) {
      cubit.setSearch(searchText!);
    }
    if (category != null) {
      final idx = ConstantData.category.indexWhere(
        (c) => c['title'] == category,
      );
      if (idx != -1) {
        cubit.changeCategory(idx);
      }
    }

    return const _ExploreScreenContent();
  }
}

class _ExploreScreenContent extends StatefulWidget {
  const _ExploreScreenContent();

  @override
  State<_ExploreScreenContent> createState() => _ExploreScreenContentState();
}

class _ExploreScreenContentState extends State<_ExploreScreenContent> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ExploreCubit>();
    searchController.text = cubit.state.search;
    searchController.addListener(() {
      cubit.setSearch(searchController.text);
    });
  }

  @override
  void didUpdateWidget(covariant _ExploreScreenContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    final cubit = context.read<ExploreCubit>();
    // Update controller if cubit search state changed
    if (searchController.text != cubit.state.search) {
      searchController.text = cubit.state.search;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _openFilterSheet(BuildContext context, ExploreState state) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      backgroundColor: Colors.white,
      builder: (_) => FilterBottomSheet(
        initialOpenOnly: state.openOnly,
        initialMinRating: state.minRating,
        onApply: (openOnly, minRating) {
          context.read<ExploreCubit>().applyFilter(openOnly, minRating);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final cubit = context.read<ExploreCubit>();

        // Update search controller if state search changed
        if (searchController.text != state.search) {
          searchController.text = state.search;
        }

        final results = cubit.getFilteredRestaurants();
        final hasActiveFilter = state.openOnly || state.minRating != null;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Restaurants",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpace(height: 16),

                  // Search + Filter button row
                  Row(
                    children: [
                      Expanded(
                        child: SearchTextFieldWidget(
                          controller: searchController,
                          hintText: 'Search restaurants, cuisines...',
                        ),
                      ),
                      WidthSpace(width: 10),
                      FilterIconButton(
                        hasActiveFilter: hasActiveFilter,
                        onTap: () => _openFilterSheet(context, state),
                      ),
                    ],
                  ),
                  HeightSpace(height: 16),

                  // Active filter chips
                  if (hasActiveFilter) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (state.openOnly)
                            ActiveFilterChip(
                              label: 'Open Now',
                              onRemove: () => cubit.removeOpenFilter(),
                            ),
                          if (state.minRating != null)
                            ActiveFilterChip(
                              label: '${state.minRating}+ ★',
                              onRemove: () => cubit.removeRatingFilter(),
                            ),
                        ],
                      ),
                    ),
                    HeightSpace(height: 8),
                  ],

                  // Category chips
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: ConstantData.category.length,
                      itemBuilder: (context, index) {
                        return CustomCategoryItemWidget(
                          isSelected: state.selectedCategoryIndex == index,
                          title: ConstantData.category[index]['title'],
                          icon: ConstantData.category[index]['icon'],
                          onTap: () => cubit.changeCategory(index),
                        );
                      },
                    ),
                  ),
                  HeightSpace(height: 8),

                  // Result count
                  Text(
                    '${results.length} restaurant${results.length == 1 ? '' : 's'} found',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xff94A3B8),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  HeightSpace(height: 8),

                  // Grid or empty state
                  results.isEmpty
                      ? const ExploreEmptyState()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: results.length > state.visibleCount
                              ? state.visibleCount
                              : results.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                                childAspectRatio: 0.75,
                              ),
                          itemBuilder: (context, index) {
                            final r = results[index];
                            return CustomListCards(
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  RouteName.restaurantPageScreen,
                                  extra: {
                                    "image": r['image'],
                                    "resName": r['resName'],
                                    "resPeopleRate": r['resPeopleRate'],
                                    "resRate": r['resRate'],
                                    "resSpace": r['resSpace'],
                                    "category": r['category'],
                                    "isOpen": r['isOpen'],
                                  },
                                );
                              },
                              isFavorite: r['isFavorite'],
                              isOpen: r['isOpen'],
                              image: AppAssets.image,
                              resName: r['resName'],
                              numReviews: r['resPeopleRate'],
                              resRate: r['resRate'],
                              resSpace: r['resSpace'],
                              category: r['category'],
                            );
                          },
                        ),
                  HeightSpace(height: 60),
                  if (state.visibleCount < results.length)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomTextButton(
                        icon: Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        isIcon: true,
                        text: "Load More",
                        onTap: () => cubit.loadMore(),
                      ),
                    ),
                  HeightSpace(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
