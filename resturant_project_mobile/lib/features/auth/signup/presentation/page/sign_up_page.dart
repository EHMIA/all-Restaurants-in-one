import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/features/auth/signup/presentation/page/widgets/custom_footer_signup.dart';
import 'package:resturant_project/core/constants/constant_validate.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

import '../../../auth_route/presentaion/cubit/auth_route_cubit.dart';
import '../cubit/signup_cubit.dart';
import '../cubit/signup_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.onLoginClicked});
  final VoidCallback onLoginClicked;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          CustomSnackBar.show(context, message: state.errorMessage, backgroundColor: AppColors.snackBarErrorColor);
        }
        if (state is SignUpSuccess) {
          CustomSnackBar.show(context, message: "Account Created Successfully", backgroundColor: AppColors.snackBarSuccessColor);

          context.read<AuthRouteCubit>().selectLoginTab();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(height: 16),

            /// Full Name
            CustomTextField(
              controller: _fullNameController,
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color:  AppColors.textFormFieldColor,
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
                fontWeight: FontWeight.bold,
              ),

              fillColor: Color(0xffF8FAFC),
              borderColor: AppColors.textFormFieldColor,
              radius: 8,

              textFieldTitle: "Full Name",
              hintText: "Enter your full name",

              keyBoardType: TextInputType.name,
            ),

            const HeightSpace(height: 16),

            /// Email
            CustomTextField(
              controller: _emailController,
              validator: (value) =>
                  ConstantValidate().validateEmail(value ?? ''),
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color:  AppColors.textFormFieldColor,
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
                fontWeight: FontWeight.bold,
              ),

              fillColor: Color(0xffF8FAFC),
              borderColor: AppColors.textFormFieldColor,
              radius: 8,

              textFieldTitle: "Email",
              hintText: "Enter your email",

              keyBoardType: TextInputType.emailAddress,
            ),

            const HeightSpace(height: 16),

            /// Phone
            CustomTextField(
              controller: _phoneController,
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color:  AppColors.textFormFieldColor,
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
                fontWeight: FontWeight.bold,
              ),

              fillColor: Color(0xffF8FAFC),
              borderColor: AppColors.textFormFieldColor,
              radius: 8,

              textFieldTitle: "Phone",
              hintText: "Enter your phone number",

              keyBoardType: TextInputType.phone,
            ),

            const HeightSpace(height: 16),

            /// Password
            CustomTextField(
              controller: _passwordController,
              validator: (value) =>
                  ConstantValidate().validatePassword(value ?? ''),
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color:  AppColors.textFormFieldColor,
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

              textFieldTitle: "Password",
              hintText: "Enter your password",

              keyBoardType: TextInputType.visiblePassword,
              isPassword: true,
            ),

            const HeightSpace(height: 16),

            /// Confirm Password
            CustomTextField(
              controller: _confirmPasswordController,
              validator: (value) => value != _passwordController.text
                  ? 'Passwords do not match'
                  : null,
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color:  AppColors.textFormFieldColor,
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

              textFieldTitle: "Confirm Password",
              hintText: "Re-enter your password",

              keyBoardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            const HeightSpace(height: 16),

            //const CustomTermsAndPrivacy(),
            const HeightSpace(height: 20),

            /// Create Account Button
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: state is SignUpLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<SignUpCubit>().signUp(
                                _emailController.text,
                                _fullNameController.text,
                                _passwordController.text,
                                _confirmPasswordController.text,
                                _phoneController.text,
                              );
                            }
                          },
                    child: state is SignUpLoading
                        ? const CircularProgressIndicator(color: AppColors.textWhiteColor)
                        : Text(
                            "Create Account",
                            style: TextStyle(
                              color: AppColors.textWhiteColor,
                              fontSize: 18.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),

            CustomFooterSignup(onLoginClicked: widget.onLoginClicked),
          ],
        ),
      ),
    );
  }
}
