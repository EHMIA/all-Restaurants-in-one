import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../cubit/settings_cubit.dart';

class SettingsDeleteAccountDialog extends StatelessWidget {
  const SettingsDeleteAccountDialog({super.key});
 
  static void show(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SettingsDeleteAccountDialogImpl(cubit: cubit),
    );
  }
 
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
 
class _SettingsDeleteAccountDialogImpl extends SettingsDeleteAccountDialog {
  const _SettingsDeleteAccountDialogImpl({required this.cubit});
 
  final SettingsCubit cubit;
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Delete Account',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.red,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 48.sp),
          HeightSpace(height: 16),
          Text(
            'Are you sure you want to delete your account?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          HeightSpace(height: 12),
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'This action cannot be undone. All your data including reviews, '
              'favorites, and profile information will be permanently deleted.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.red.shade800,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.grayColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            cubit.deleteAccount();
            Navigator.pop(context);
          },
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}