import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_page_cubit.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_menu_head_title.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/custom_res_menu_appetizers_card.dart';

import '../../cubit/restaurant_page_state.dart';

class CustomResMenuPage extends StatefulWidget {
  const CustomResMenuPage({super.key, required this.restaurantId});
  final String restaurantId;
  @override
  State<CustomResMenuPage> createState() => _CustomResMenuPageState();
}

class _CustomResMenuPageState extends State<CustomResMenuPage> {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantPageCubit, RestaurantPageState>(
      builder: (context, state) {
        if (state is RestaurantPageLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        if (state is RestaurantPageError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.primaryColor,
                    size: 48.sp,
                  ),
                  HeightSpace(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is RestaurantPageSuccess) {
          final menu = state.model.data.menu;
          
          final groupedMenu = <String, List<dynamic>>{};
          for (var item in menu) {
            if (!groupedMenu.containsKey(item.category)) {
              groupedMenu[item.category] = [];
            }
            groupedMenu[item.category]!.add(item);
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...groupedMenu.entries.map((entry) {
                    final category = entry.key;
                    final items = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomResMenuHeadTitle(
                          title: category,
                          appetizersItemsCount: items.length,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return CustomResMenuAppetizersCard(
                              image: item.imageUrl,
                              title: item.dishName,
                              description: item.description,
                              price: '${item.price} EGP',
                            );
                          },
                        ),
                        HeightSpace(height: 32),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
