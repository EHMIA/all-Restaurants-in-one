import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';

class ProfilePicturePickerWidget extends StatelessWidget {
  final String? localImagePath;

  final String? networkImageUrl;

  final String assetFallback;

  final VoidCallback onTap;

  const ProfilePicturePickerWidget({
    super.key,
    this.localImagePath,
    this.networkImageUrl,
    required this.assetFallback,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Priority: local picked file > network URL > asset placeholder
    Widget imageWidget;

    final hasLocal =
        localImagePath != null &&
        localImagePath!.isNotEmpty &&
        File(localImagePath!).existsSync();

    final hasNetwork = networkImageUrl != null && networkImageUrl!.isNotEmpty;

    if (hasLocal) {
      imageWidget = Image.file(File(localImagePath!), fit: BoxFit.cover);
    } else if (hasNetwork) {
      imageWidget = Image.network(
        networkImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Image.asset(assetFallback, fit: BoxFit.cover),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                  : null,
              color: AppColors.primaryColor,
              strokeWidth: 2,
            ),
          );
        },
      );
    } else {
      imageWidget = Image.asset(assetFallback, fit: BoxFit.cover);
    }

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
            child: imageWidget,
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
