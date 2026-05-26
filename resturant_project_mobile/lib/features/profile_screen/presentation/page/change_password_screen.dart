import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/profile_screen/data/repository/edit_profile_repo.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/change_password_cubit.dart';
import '../../../../../core/constants/constant_validate.dart';
import '../cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.resetToken});
  final String resetToken;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleChangePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ChangePasswordCubit>().updatePassword(
        currentPassword: _currentPassword.text,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        repo: EditProfileRepo(api: DioConsumer(dio: Dio())),
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgoroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textBlackColor,
              size: 28.sp,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.snackBarSuccessColor,
                  duration: const Duration(seconds: 2),
                ),
              );
            }

            if (state is ChangePasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: AppColors.snackBarErrorColor,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
            if (state is ChangePasswordSuccess) {
              CustomSnackBar.show(
                context,
                message: state.message,
                backgroundColor: AppColors.snackBarSuccessColor,
              );
              GoRouter.of(context).pop();
            } else if (state is ChangePasswordFailure) {
              CustomSnackBar.show(
                context,
                message: state.error,
                backgroundColor: AppColors.snackBarErrorColor,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(24.sp),
                    decoration: BoxDecoration(
                      color: AppColors.containerWhiteColor,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5.r,
                          blurRadius: 15.r,
                          color: AppColors.shadowColor,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeightSpace(height: 20),
                          //const CustomChangePasswordHeader(),

                          const HeightSpace(height: 40),
                          CustomTextField(
                            controller: _currentPassword,
                            validator: (value) => ConstantValidate()
                                .validatePassword(value ?? ''),
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
                              Icons.lock_outline,
                              color: AppColors.textFormFieldColor,
                              size: 25.sp,
                            ),

                            fillColor: Color(0xffF8FAFC),
                            borderColor: AppColors.textFormFieldColor,
                            radius: 8,

                            textFieldTitle: "Current Password",
                            hintText: "Enter your current password",

                            isPassword: true,
                          ),
                          HeightSpace(height: 15),
                          CustomTextField(
                            controller: _newPasswordController,
                            validator: (value) => ConstantValidate()
                                .validatePassword(value ?? ''),
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
                              Icons.lock_outline,
                              color: AppColors.textFormFieldColor,
                              size: 25.sp,
                            ),

                            fillColor: Color(0xffF8FAFC),
                            borderColor: AppColors.textFormFieldColor,
                            radius: 8,

                            textFieldTitle: "New Password",
                            hintText: "Enter your new password",

                            isPassword: true,
                          ),
                          HeightSpace(height: 15),

                          //const CustomPasswordRequirementsChangePassword(),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            validator: (value) => ConstantValidate()
                                .validatePassword(value ?? ''),
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
                              Icons.lock_outline,
                              color: AppColors.textFormFieldColor,
                              size: 25.sp,
                            ),

                            fillColor: Color(0xffF8FAFC),
                            borderColor: AppColors.textFormFieldColor,
                            radius: 8,

                            textFieldTitle: "Comfirm Password",
                            hintText: "Comfirm your new password",

                            isPassword: true,
                          ),

                          const HeightSpace(height: 32),

                          SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is ChangePasswordLoading ? null : ()=>_handleChangePassword(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: state is ChangePasswordLoading
            ? const CircularProgressIndicator(color: AppColors.textWhiteColor)
            : Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhiteColor,
                ),
              ),
      ),
    ),

                          const HeightSpace(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
