import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';

class ProfilePicturePickerWidget extends StatelessWidget {
  final String? imagePathOrAsset;
  final bool isAssetImage;
  final VoidCallback onTap;

  const ProfilePicturePickerWidget({
    super.key,
    this.imagePathOrAsset,
    this.isAssetImage = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 140.h,
          width: 140.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200.r),
            child: imagePathOrAsset != null
                ? (isAssetImage
                      ? Image.asset(imagePathOrAsset!, fit: BoxFit.cover)
                      : Image.file(
                          throw Exception('File path not supported yet'),
                          fit: BoxFit.cover,
                        ))
                : Container(
                    color: AppColors.textFormFillColor,
                    child: Icon(
                      Icons.person,
                      size: 80.sp,
                      color: AppColors.grayColor,
                    ),
                  ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50.h,
            width: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ),
      ],
    );
  }
}
