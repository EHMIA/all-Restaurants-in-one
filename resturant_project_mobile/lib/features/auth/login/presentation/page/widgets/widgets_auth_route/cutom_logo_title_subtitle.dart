import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/spacing_widgets.dart';

class CutomLogoTitleSubtitle extends StatelessWidget {
  const CutomLogoTitleSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Logo
        HeightSpace(height: 32),
        CircleAvatar(
          radius: 35.r,
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          child: Icon(Icons.restaurant, color: Colors.red, size: 35.sp),
        ),

        const SizedBox(height: 12),

        /// Title
        Text(
          "Akiel",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),

        const SizedBox(height: 4),

        /// Subtitle
        Text(
          "Welcome! Login or Create an Account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: Color(0xff64748B),
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}