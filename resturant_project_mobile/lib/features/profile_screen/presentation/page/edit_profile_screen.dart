import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/constants/constant_validate.dart';
import 'package:resturant_project/features/profile_screen/data/repository/edit_profile_repo.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/edit_profile_cubit.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/edit_profile_state.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/custom_toggle_switch_widget.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/profile_picture_picker_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _loadUserData(); 
  }

  Future<void> _loadUserData() async {
    final data = await StorageHelper.getUserData();
    setState(() {
      _fullNameController.text = data['name'] ?? '';
      _emailController.text = data['email'] ?? '';
      _phoneController.text = data['phone'] ?? '';
      _addressController.text = data['address'] ?? '';
    });
  }

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
    return BlocProvider(
      create: (context) => EditProfileCubit(repo: EditProfileRepo(api: DioConsumer(dio: Dio()))),
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
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Section
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      final cubit = context.read<EditProfileCubit>();
                      return ProfilePicturePickerWidget(
                        imagePathOrAsset:
                            cubit.selectedImagePath ?? AppAssets.profile,
                        isAssetImage: cubit.selectedImagePath == null,
                        onTap: () {
                          _showImagePickerDialog(context);
                        },
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
              HeightSpace(height: 32),
              // All Fields in Card Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      children: [
                        HeightSpace(height: 15),
                        // Full Name Field
                        CustomTextField(
                          controller: _fullNameController,
                          validator: (value) =>
                              ConstantValidate().validateEmail(value ?? ''),
                          hintTextStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textFormFieldColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: AppColors.textFormFieldColor,
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: AppColors.textFormFieldColor,
                            size: 25.sp,
                          ),
                          fillColor: Color(0xffF8FAFC),
                          borderColor: AppColors.textFormFieldColor,
                          radius: 8,
                          textFieldTitle: "Full Name",
                          hintText: "Enter your full name",
                        ),
                        HeightSpace(height: 15),
                        // Email Address Field
                        CustomTextField(
                          controller: _emailController,
                          validator: (value) =>
                              ConstantValidate().validateEmail(value ?? ''),
                          hintTextStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textFormFieldColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: AppColors.textFormFieldColor,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.textFormFieldColor,
                            size: 25.sp,
                          ),
                          fillColor: Color(0xffF8FAFC),
                          borderColor: AppColors.textFormFieldColor,
                          radius: 8,
                          textFieldTitle: "Email Address",
                          hintText: "Enter your email",
                          keyBoardType: TextInputType.emailAddress,
                        ),
                        HeightSpace(height: 15),
                        // Phone Number Field
                        CustomTextField(
                          controller: _phoneController,
                          validator: (value) =>
                              ConstantValidate().validateEmail(value ?? ''),
                          hintTextStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textFormFieldColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: AppColors.textFormFieldColor,
                          ),
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: AppColors.textFormFieldColor,
                            size: 25.sp,
                          ),
                          fillColor: Color(0xffF8FAFC),
                          borderColor: AppColors.textFormFieldColor,
                          radius: 8,
                          textFieldTitle: "Phone Number",
                          hintText: "Enter your phone number",
                          keyBoardType: TextInputType.phone,
                        ),
                        HeightSpace(height: 15),
                        // Address Field
                        CustomTextField(
                          controller: _addressController,
                          validator: (value) =>
                              ConstantValidate().validateEmail(value ?? ''),
                          hintTextStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textFormFieldColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: AppColors.textFormFieldColor,
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.textFormFieldColor,
                            size: 25.sp,
                          ),
                          fillColor: Color(0xffF8FAFC),
                          borderColor: AppColors.textFormFieldColor,
                          radius: 8,
                          textFieldTitle: "Address",
                          hintText: "Enter your address",
                        ),
                        HeightSpace(height: 15),
                        // Change Password Button
                        GestureDetector(
                          onTap: () {
                            _showChangePasswordDialog(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                color: AppColors.primaryColor,
                                size: 24.sp,
                              ),
                              WidthSpace(width: 12),
                              Text(
                                'Change Password',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        HeightSpace(height: 15),
                        // Notifications Toggle
                        BlocBuilder<EditProfileCubit, EditProfileState>(
                          builder: (context, state) {
                            final cubit = context.read<EditProfileCubit>();
                            return CustomToggleSwitchWidget(
                              label: 'App Notifications',
                              description: 'Stay updated with restaurant deals',
                              value: cubit.notificationsEnabled,
                              onChanged: (value) {
                                context
                                    .read<EditProfileCubit>()
                                    .toggleNotifications(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              HeightSpace(height: 32),
              // Save Changes Button
              BlocListener<EditProfileCubit, EditProfileState>(
                listener: (context, state) {
                  if (state is EditProfileSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: AppColors.snackBarSuccessColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Future.delayed(Duration(seconds: 1), () {
                      context.pop(true);
                    });
                  } else if (state is EditProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: AppColors.snackBarErrorColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      final isLoading = state is EditProfileLoading;
                      return GestureDetector(
                        onTap: isLoading
                            ? null
                            : () {
                                context.read<EditProfileCubit>().saveChanges(
                                  fullname: _fullNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  address: _addressController.text.trim(),
                                );
                              },
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isLoading
                                ? AppColors.primaryColor.withValues(alpha: 0.6)
                                : AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.2,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 24.sp,
                                  width: 24.sp,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Save Changes',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
              onTap: () {
                // Add camera implementation here
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Camera functionality coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
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
            Divider(thickness: 0.5),
            GestureDetector(
              onTap: () {
                // Add gallery implementation here
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Gallery functionality coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: AppColors.primaryColor,
                      size: 24.sp,
                    ),
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
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Change Password',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  filled: true,
                  fillColor: AppColors.textFormFillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  filled: true,
                  fillColor: AppColors.textFormFillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  filled: true,
                  fillColor: AppColors.textFormFillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.grayColor,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<EditProfileCubit>().changePassword();
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password changed successfully'),
                  backgroundColor: AppColors.snackBarSuccessColor,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              'Update',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
