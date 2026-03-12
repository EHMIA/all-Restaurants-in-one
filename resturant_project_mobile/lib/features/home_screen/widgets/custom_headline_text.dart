import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeadlineText extends StatelessWidget {
  const CustomHeadlineText({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      height: 130.h,
      child: Text(
        text??'',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          height: 1.3.h,
        ),
      ),
    );
  }
}
