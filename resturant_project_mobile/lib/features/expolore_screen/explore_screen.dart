import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/constants/constant_data.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_bottom.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/expolore_screen/widgets/custom_list_cards.dart';
import 'package:resturant_project/features/core/widgets/custom_category_item.dart';
import 'package:resturant_project/features/home_screen/widgets/search_text_field_widget.dart';
import 'package:resturant_project/features/expolore_screen/widgets/filter_icon_button.dart';
import 'package:resturant_project/features/expolore_screen/widgets/filter_bottom_sheet.dart';
import 'package:resturant_project/features/expolore_screen/widgets/active_filter_chip.dart';
import 'package:resturant_project/features/expolore_screen/widgets/explore_empty_state.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, this.searchText, this.category});
  final String? searchText;
  final String? category;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();

  int isSelectedIndex = 0;
  bool _filterOpenOnly = false;
  double? _filterMinRating;
  int _visibleCount = 4;

  @override
  void initState() {
    super.initState();
    searchController.text = widget.searchText ?? '';

    if (widget.category != null) {
      final idx = ConstantData.category.indexWhere(
        (c) => c['title'] == widget.category,
      );
      if (idx != -1) isSelectedIndex = idx;
    }

    searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool get _hasActiveFilter => _filterOpenOnly || _filterMinRating != null;

  List<Map<String, dynamic>> get _filteredRestaurants {
    final query = searchController.text.trim().toLowerCase();
    final selectedCategory = isSelectedIndex == 0
        ? null
        : ConstantData.category[isSelectedIndex]['title'] as String?;

    return ConstantData.restaurants.where((r) {
      if (query.isNotEmpty) {
        final name = (r['resName'] as String).toLowerCase();
        final cat = (r['category'] as String).toLowerCase();
        if (!name.contains(query) && !cat.contains(query)) return false;
      }
      if (selectedCategory != null && r['category'] != selectedCategory) {
        return false;
      }
      if (_filterOpenOnly && r['isOpen'] != true) return false;
      if (_filterMinRating != null) {
        final rate = double.tryParse(r['resRate'] ?? '0') ?? 0;
        if (rate < _filterMinRating!) return false;
      }
      return true;
    }).toList();
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      backgroundColor: Colors.white,
      builder: (_) => FilterBottomSheet(
        initialOpenOnly: _filterOpenOnly,
        initialMinRating: _filterMinRating,
        onApply: (openOnly, minRating) {
          setState(() {
            _filterOpenOnly = openOnly;
            _filterMinRating = minRating;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredRestaurants;

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
                      onPressed: () {},
                      hintText: 'Search restaurants, cuisines...',
                    ),
                  ),
                  WidthSpace(width: 10),
                  FilterIconButton(
                    hasActiveFilter: _hasActiveFilter,
                    onTap: _openFilterSheet,
                  ),
                ],
              ),
              HeightSpace(height: 16),

              // Active filter chips
              if (_hasActiveFilter) ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (_filterOpenOnly)
                        ActiveFilterChip(
                          label: 'Open Now',
                          onRemove: () =>
                              setState(() => _filterOpenOnly = false),
                        ),
                      if (_filterMinRating != null)
                        ActiveFilterChip(
                          label: '$_filterMinRating+ ★',
                          onRemove: () =>
                              setState(() => _filterMinRating = null),
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
                      isSelected: isSelectedIndex == index,
                      title: ConstantData.category[index]['title'],
                      icon: ConstantData.category[index]['icon'],
                      onTap: () => setState(() => isSelectedIndex = index),
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
                      itemCount: results.length > _visibleCount
                          ? _visibleCount
                          : results.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              if (_visibleCount < results.length)
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomTextButton(
                    icon: Icons.keyboard_arrow_down_outlined,

                    color: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    isIcon: true,
                    text: "Load More",
                    onTap: () {
                      setState(() {
                        _visibleCount += 4;
                      });
                    },
                  ),
                ),
              HeightSpace(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
