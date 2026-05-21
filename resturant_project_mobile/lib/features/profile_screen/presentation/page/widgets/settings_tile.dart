import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isDestructive = false,
    this.iconColor,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isDestructive;
  final Color? iconColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Colors.red
        : (iconColor ?? AppColors.primaryColor);

    return Column(
      children: [
        HeightSpace(height: 8),
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Icon(icon, color: color, size: 24.sp),
              WidthSpace(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isDestructive ? Colors.red : Colors.black87,
                      ),
                    ),
                    if (subtitle != null) ...[
                      HeightSpace(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: isDestructive ? Colors.red : Colors.grey.shade400,
                size: 16.sp,
              ),
            ],
          ),
        ),
        if (showDivider) ...[
          HeightSpace(height: 8),
          Divider(color: Colors.grey.shade100, thickness: 0.5, height: 1),
        ] else
          HeightSpace(height: 8),
      ],
    );
  }
}
