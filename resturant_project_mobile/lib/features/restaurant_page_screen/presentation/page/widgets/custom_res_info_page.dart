import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_main_data_cubit.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_main_data_state.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/widgets/restaurant_info_shimmer_loading.dart';

class CustomResInfoPage extends StatelessWidget {
  const CustomResInfoPage({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    // Use the Cubit from parent (CustomResTabBarPage)
    return BlocBuilder<RestaurantMainDataCubit, RestaurantMainDataState>(
      builder: (context, state) {
        if (state is RestaurantMainDataLoading) {
          return const RestaurantInfoShimmerLoading();
        }
        if (state is RestaurantMainDataError) {
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
        if (state is RestaurantMainDataSuccess) {
          final info = state.restaurant.data.first;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // General Information Section
                  Text(
                    'General Information',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(height: 7),
                  Text(
                    info.description ?? 'No description available',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14.sp,
                      color: AppColors.grayColor,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  HeightSpace(height: 24),

                  // Location Section
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(height: 7),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: AppColors.primaryColor),
                      WidthSpace(width: 8),
                      Expanded(
                        child: Text(
                          info.getFullAddress(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Poppins",
                            color: Color(0xff0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(height: 24),

                  // Opening Hours Section
                  Text(
                    'Opening Hours',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(height: 12),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        children: info.openingHours.isEmpty
                            ? [
                                Text(
                                  'No opening hours available',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.grayColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ]
                            : List.generate(info.openingHours.length, (index) {
                                final hours = info.openingHours[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index < info.openingHours.length - 1
                                        ? 12.h
                                        : 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        hours.day,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: AppColors.grayColor,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        hours.isClosed
                                            ? 'Closed'
                                            : '${hours.opens} - ${hours.closes}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: hours.isClosed
                                              ? Colors.red
                                              : Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                      ),
                    ),
                  ),
                  HeightSpace(height: 24),

                  // Contact Information Section
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(height: 12),
                  if (info.phoneNumber.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Icon(Icons.phone, color: AppColors.primaryColor),
                          WidthSpace(width: 8),
                          Text(
                            info.phoneNumber,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "Poppins",
                              color: Color(0xff0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (info.whatsappNumber != null &&
                      info.whatsappNumber!.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.message, color: AppColors.primaryColor),
                        WidthSpace(width: 8),
                        Text(
                          'WhatsApp: ${info.whatsappNumber}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Poppins",
                            color: Color(0xff0F172A),
                          ),
                        ),
                      ],
                    ),
                  HeightSpace(height: 24),

                  // Social Media Section
                  if (info.facebookLink != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Social Media',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HeightSpace(height: 12),
                        Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: [
                            if (info.facebookLink != null)
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Opening Facebook: ${info.facebookLink}',
                                      ),
                                    ),
                                  );
                                },
                                child: Chip(
                                  avatar: Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Facebook',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
