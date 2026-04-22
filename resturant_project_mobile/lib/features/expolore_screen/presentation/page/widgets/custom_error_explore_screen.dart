import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/custom_text_bottom.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../cubit/explore_cubit.dart';

class CustomErrorExploreScreen extends StatelessWidget {
  const CustomErrorExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExploreCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 50.sp, color: AppColors.grayColor),
            HeightSpace(height: 12),
            Text(
              //state.message,
              'Something went wrong',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'Poppins',
                color: AppColors.grayColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            HeightSpace(height: 15),
            CustomTextButton(
              isIcon: false,
              onTap: () => cubit.getHomeFeature(),
              backgroundColor: AppColors.primaryColor,
              radius: 15.r,
              width: 120.w,
              text: 'Retry',
            ),
          ],
        ),
      ),
    );
    
  }
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
