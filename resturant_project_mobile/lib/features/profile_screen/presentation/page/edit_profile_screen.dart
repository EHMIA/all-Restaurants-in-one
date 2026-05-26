import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/profile_screen/data/repository/edit_profile_repo.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/edit_profile_cubit.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/edit_profile_state.dart';
import '../../data/repository/profile_repo.dart';
import 'widgets/edit_profile_avtare_section.dart';
import 'widgets/edit_profile_fields_card.dart';
import 'widgets/edit_profile_save_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(
        repo: EditProfileRepo(api: DioConsumer(dio: Dio())),
        userRepo: UserRepo(api: DioConsumer(dio: Dio())),
      )..loadUserData(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileLoaded) {
          _fullNameController.text = state.fullName;
          _emailController.text = state.email;
          _phoneController.text = state.phone;
          _addressController.text = state.address;
        }

        if (state is EditProfileSuccess) {
          CustomSnackBar.show(
            context,
            message: "${state.message}",
            backgroundColor: AppColors.snackBarSuccessColor,
          );
          Future.delayed(const Duration(seconds: 1), () {
            context.pop(true);
          });
        }

        if (state is EditProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.snackBarErrorColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        if (state is DeleteProfilePictureSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.snackBarSuccessColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        if (state is DeleteProfilePictureError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.snackBarErrorColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state is EditProfileLoading &&
                _fullNameController.text.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const EditProfileAvatarSection(),
                  HeightSpace(height: 32),
                  EditProfileFieldsCard(
                    fullNameController: _fullNameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    addressController: _addressController,
                  ),
                  HeightSpace(height: 32),
                  EditProfileSaveButton(
                    fullNameController: _fullNameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    addressController: _addressController,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
