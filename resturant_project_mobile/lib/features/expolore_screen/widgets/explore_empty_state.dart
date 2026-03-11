import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class ExploreEmptyState extends StatelessWidget {
  const ExploreEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: Colors.grey[300],
            ),
            HeightSpace(height: 16),
            Text(
              'No restaurants found',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
            HeightSpace(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'Poppins',
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
