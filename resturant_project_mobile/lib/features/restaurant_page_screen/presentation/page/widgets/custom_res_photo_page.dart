import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_page_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../cubit/restaurant_page_state.dart';

class CustomResPhotoPage extends StatefulWidget {
  const CustomResPhotoPage({super.key, required this.restaurantId});
  final String restaurantId;
  @override
  State<CustomResPhotoPage> createState() => _CustomResPhotoPageState();
}

class _CustomResPhotoPageState extends State<CustomResPhotoPage> {
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
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is RestaurantPageSuccess) {
          final photos = state.model.data.gallery;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photos',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${photos.length} Photos from guests & owner',
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 12.sp,
                    color: AppColors.grayColor,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6.w,
                      mainAxisSpacing: 6.h,
                    ),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 173.h,
                        width: 173.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: CachedNetworkImage(
                            imageUrl: photos[index].url,

                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,

                            memCacheWidth: 600,
                            memCacheHeight: 400,

                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(color: Colors.white),
                            ),

                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: Icon(
                                Icons.broken_image_rounded,
                                size: 40.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
