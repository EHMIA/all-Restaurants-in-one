import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../cubit/edit_profile_cubit.dart';
import 'edit_profile_deleted_pecture_dialog.dart';

class EditProfileImagePickerDialog extends StatelessWidget {
  const EditProfileImagePickerDialog({super.key});

  static void show(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    showDialog(
      context: context,
      builder: (_) => EditProfileImagePickerDialog._withCubit(cubit, context),
    );
  }
  factory EditProfileImagePickerDialog._withCubit(
    EditProfileCubit cubit,
    BuildContext parentContext,
  ) => _EditProfileImagePickerDialogImpl(
    cubit: cubit,
    parentContext: parentContext,
  );

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _EditProfileImagePickerDialogImpl extends EditProfileImagePickerDialog {
  const _EditProfileImagePickerDialogImpl({
    required this.cubit,
    required this.parentContext,
  });

  final EditProfileCubit cubit;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Choose Profile Picture',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              await cubit.pickFromCamera();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: AppColors.primaryColor,
                    size: 24.sp,
                  ),
                  WidthSpace(width: 16),
                  Text(
                    'Take Photo',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 0.5),

          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              await cubit.pickFromGallery();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  Icon(Icons.image, color: AppColors.primaryColor, size: 24.sp),
                  WidthSpace(width: 16),
                  Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 0.5),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              EditProfileDeletePictureDialog.show(parentContext);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: Colors.red, size: 24.sp),
                  WidthSpace(width: 16),
                  Text(
                    'Delete Picture',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
