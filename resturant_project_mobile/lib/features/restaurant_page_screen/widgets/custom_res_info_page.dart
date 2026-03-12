import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomResInfoPage extends StatelessWidget {
  const CustomResInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
        ],
      ),
    );
  }
}
