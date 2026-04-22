import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_page_cubit.dart';

import '../../cubit/restaurant_page_state.dart';

class CustomResInfoPage extends StatelessWidget {
  const CustomResInfoPage({super.key});

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
        if(state is RestaurantPageSuccess){
          // code to apply api here
          return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  '''Sobhy Kaber (Koshary Luxury) is a legendary culinarydestination in Cairo, renowned for its authenticEgyptian flavors and premium quality ingredients.Specializing in traditional grills and the finest Egyptianstaples, we provide an upscale dining experiencerooted in heritage.''',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14.sp,
                    color: AppColors.grayColor,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                HeightSpace(height: 24),
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
                  children: [
                    Icon(Icons.location_on, color: AppColors.primaryColor),
                    WidthSpace(width: 8),
                    Text(
                      '94 El Merghany St, Heliopolis, Cairo, Egypt',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Poppins",
                        color: Color(0xff0F172A),
                      ),
                    ),
                  ],
                ),
                HeightSpace(height: 24),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Monday',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.grayColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              '11:00 AM - 01:00 AM',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                HeightSpace(height: 24),
                Text(
                  'Social Media',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
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
