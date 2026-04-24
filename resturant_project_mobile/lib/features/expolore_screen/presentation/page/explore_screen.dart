import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/constants/constant_data.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_text_bottom.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/expolore_screen/presentation/cubit/explore_cubit.dart';
import 'package:resturant_project/features/expolore_screen/presentation/cubit/explore_state.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/custom_list_cards.dart';
import 'package:resturant_project/core/widgets/custom_category_item.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/filter_icon_button.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/filter_bottom_sheet.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/active_filter_chip.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/explore_no_result_screen.dart';
import '../../../favorite_screen/presentation/cubit/favorite_cubit.dart';
import '../../../home_screen/presentation/page/widgets/search_text_field_widget.dart';
import 'widgets/custom_error_explore_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key, this.searchText, this.category});

  final String? searchText;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return _ExploreScreenContent(
      initialSearch: searchText,
      initialCategory: category,
    );
  }
}

class _ExploreScreenContent extends StatefulWidget {
  const _ExploreScreenContent({this.initialSearch, this.initialCategory});

  final String? initialSearch;
  final String? initialCategory;

  @override
  State<_ExploreScreenContent> createState() => _ExploreScreenContentState();
}

class _ExploreScreenContentState extends State<_ExploreScreenContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ExploreCubit>();

    if (widget.initialSearch != null && widget.initialSearch!.isNotEmpty) {
      cubit.setSearch(widget.initialSearch!);
    }
    if (widget.initialCategory != null) {
      final idx = ConstantData.category.indexWhere(
        (c) => c['title'] == widget.initialCategory,
      );
      if (idx != -1) cubit.changeCategory(idx);
    }
    _searchController.text = cubit.state.search;
    _searchController.addListener(() {
      context.read<ExploreCubit>().setSearch(_searchController.text);
    });
    cubit.getHomeFeature();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final cubit = context.read<ExploreCubit>();

        if (_searchController.text != state.search) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _searchController.text != state.search) {
              _searchController.text = state.search;
              _searchController.selection = TextSelection.fromPosition(
                TextPosition(offset: _searchController.text.length),
              );
            }
          });
        }

        if (state is ExploreLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _buildAppBar(),
            body: const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor,),
            ),
          );
        }
        if (state is ExploreError) {
          return const CustomErrorExploreScreen();
        }
        final favCubit = context.watch<FavoriteCubit>();
        final results = cubit.getFilteredRestaurants();
        final hasActiveFilter = state.openOnly || state.minRating != null;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpace(height: 16),

                  // Search + Filter row
                  Row(
                    children: [
                      Expanded(
                        child: SearchTextFieldWidget(
                          controller: _searchController,
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

                  Text(
                    '${results.length} restaurant${results.length == 1 ? '' : 's'} found',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xff94A3B8),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  HeightSpace(height: 8),

                  results.isEmpty
                      ? const ExploreNoResultScreen()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                            final res = results[index];
                            return CustomListCards(
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  RouteName.restaurantPageScreen,
                                  extra: res,
                                );
                              },
                              isFavorite: favCubit.isFavorite(res.id),
                              isOpen: res.isOpen,
                              image: res.coverPhoto.url,                                  
                              resName: res.name,
                              numReviews: res.reviewsCount.toString(),
                              resRate: res.rating.toString(),
                              categories: res.cuisineType,
                            );
                          },
                        ),

                  HeightSpace(height: 16),

                  // Load More button
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "Restaurants",
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
