import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../cubit/edit_profile_cubit.dart';

class EditProfileDeletePictureDialog extends StatelessWidget {
  const EditProfileDeletePictureDialog({super.key});

  static void show(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _EditProfileDeletePictureDialogImpl(cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _EditProfileDeletePictureDialogImpl
    extends EditProfileDeletePictureDialog {
  const _EditProfileDeletePictureDialogImpl({required this.cubit});

  final EditProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Delete Profile Picture',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      content: Text(
        'Are you sure you want to delete your profile picture?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          color: Colors.black87,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.grayColor, fontFamily: 'Poppins'),
          ),
        ),
        TextButton(
          onPressed: () {
            cubit.deleteProfilePicture();
            Navigator.pop(context);
          },
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
