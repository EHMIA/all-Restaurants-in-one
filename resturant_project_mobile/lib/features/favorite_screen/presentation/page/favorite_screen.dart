import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/core/manager/favorite_repository.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/widgets/custom_list_cards.dart';
import 'package:resturant_project/features/favorite_screen/presentation/page/favorite_empty_screen.dart';
import 'package:resturant_project/features/favorite_screen/presentation/bloc/favorite_bloc.dart';
import 'package:resturant_project/features/favorite_screen/presentation/bloc/favorite_event.dart';
import 'package:resturant_project/features/favorite_screen/presentation/bloc/favorite_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(FavoriteRepository())..add(LoadFavorites()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Favorites",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list, color: AppColors.primaryColor),
            ),
            WidthSpace(width: 16),
          ],
        ),

        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state.favorites.isEmpty) {
              return const FavoriteEmptyScreen();
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Container(
                    height: 128.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffFAFAFA), Color(0xffFFFDE7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Favorites",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 31.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                constraints: BoxConstraints(minWidth: 107.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: Color(
                                    0xffE23744,
                                  ).withValues(alpha: 0.1),
                                ),
                                child: Center(
                                  child: Text(
                                    "${state.favorites.length} restaurants",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "Poppins",
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          HeightSpace(height: 8),
                          Text(
                            "All the restaurants you loved and saved.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                              color: Color(0xff475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Grid
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.favorites.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.h,
                        crossAxisSpacing: 8.w,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final item = state.favorites[index];
                        final isPendingRemoval = state.pendingRemoval.contains(
                          index,
                        );

                        return CustomListCards(
                          onFavoriteToggle: () {
                            context.read<FavoriteBloc>().add(
                              ToggleFavorite(index),
                            );
                          },

                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              RouteName.restaurantPageScreen,
                              extra: item,
                            );
                          },

                          isFavorite: !isPendingRemoval,
                          image: item['image'],
                          resName: item['resName'],
                          numReviews: item['resPeopleRate'],
                          resRate: item['resRate'],
                          resSpace: item['resSpace'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
