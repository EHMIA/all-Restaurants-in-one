import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonResPage extends StatelessWidget {
  const CustomButtonResPage({super.key, this.onTap, this.icon});
  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Icon(icon, color: Colors.white),
                    ),
                  );
  }
}