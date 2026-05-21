import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_password_requirements_reset_password.dart';
import 'package:resturant_project/features/auth/login/data/repository/reset_password_repo.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import '../cubit/reset_password_cubit.dart';
import '../cubit/reset_password_state.dart';
import 'widgets/custom_reset_password_header.dart';
import 'widgets/custom_reset_password_button.dart';
import 'widgets/custom_back_to_login_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.resetToken});
  final String resetToken;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';
    if (value.length < 8) return 'Must be at least 8 characters';
    if (!value.contains(RegExp(r'[0-9]'))) return 'Must contain a number';
    return null;
  }

  void _handlePasswordReset(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().resetPassword(
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
        token: widget.resetToken,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        resetPasswordRepo: ResetPasswordRepo(api: DioConsumer(dio: Dio())),
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
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              CustomSnackBar.show(
                context,
                message: state.message,
                backgroundColor: AppColors.snackBarSuccessColor,
              );
              context.goNamed(RouteName.authRouteScreen);
            } else if (state is ResetPasswordFailure) {
              CustomSnackBar.show(
                context,
                message: state.errorMessage,
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
                          const CustomResetPasswordHeader(),

                          const HeightSpace(height: 40),

                          CustomTextField(
                            controller: _newPasswordController,
                            validator: _validatePassword,
                            textFieldTitle: "New Password",
                            hintText: "Enter new password",
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.textFormFieldColor,
                              size: 25.sp,
                            ),
                          ),

                          const CustomPasswordRequirementsResetPassword(),

                          CustomTextField(
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            textFieldTitle: "Confirm Password",
                            hintText: "Confirm your password",
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.textFormFieldColor,
                              size: 25.sp,
                            ),
                          ),

                          const HeightSpace(height: 32),

                          CustomResetPasswordButton(
                            isLoading: state is ResetPasswordLoading,
                            onPressed: () => _handlePasswordReset(context),
                          ),

                          const HeightSpace(height: 20),

                          CustomBackToLoginButton(
                            onTap: () =>
                                context.goNamed(RouteName.authRouteScreen),
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
