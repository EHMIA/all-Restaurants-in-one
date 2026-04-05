import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/spacing_widgets.dart';

class CustomPasswordRequirementsResetPassword extends StatelessWidget {
  const CustomPasswordRequirementsResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeightSpace(height: 20),

        _buildRequirementsList(),

        const HeightSpace(height: 20),
      ],
    );
    
  }
  Widget _buildRequirementsList() {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: const Color(0xffFFF8F0),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xffFFEDD5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password Requirements:",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff64748B),
            ),
          ),
          const HeightSpace(height: 8),
          _buildRequirementRow("At least 8 characters"),
          _buildRequirementRow("At least 1 uppercase letter"),
          _buildRequirementRow("At least 1 number"),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 14.sp,
            color: const Color(0xff94A3B8),
          ),
          const WidthSpace(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xff64748B)),
          ),
        ],
      ),
    );
  }
}