import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/profile_picture_picker_widget.dart';
import '../../../../../core/app_assets/app_assets.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../cubit/edit_profile_cubit.dart';
import '../../cubit/edit_profile_state.dart';
import 'edit_profile_image_picker_dialog.dart';

class EditProfileAvatarSection extends StatelessWidget {
  const EditProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Center(
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                final cubit = context.read<EditProfileCubit>();
                final localPath = cubit.selectedImageFile?.path;
                final networkUrl = cubit.networkProfilePic;

                return ProfilePicturePickerWidget(
                  localImagePath: localPath,
                  networkImageUrl: networkUrl,
                  assetFallback: AppAssets.profile,
                  onTap: () => EditProfileImagePickerDialog.show(context),
                );
              },
            ),
          ),
        ),
        Center(
          child: Text(
            'Change Profile Picture',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
