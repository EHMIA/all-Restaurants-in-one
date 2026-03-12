import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.text,
    this.width,
    this.icon,
    this.color,
    this.radius,
    required this.isIcon,
  });
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String? text;
  final double? width;
  final IconData? icon;
  final Color? color;
  final double? radius;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 165.w,
        height: 53.h,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius ?? 22.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon == true) ...[
              Icon(icon ?? Icons.error, color: Colors.white, size: 25.sp),
              WidthSpace(width: 8),
            ],
            Text(
              text ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
