import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/auth/signup/presentation/page/widgets_signup/custom_footer_signup.dart';
import 'package:resturant_project/features/auth/signup/presentation/page/widgets_signup/custom_terms_and_privacy.dart';
import 'package:resturant_project/features/core/constants/constant_validate.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

import '../../../../signup/presentation/bloc/signup_bloc.dart';
import '../../../../signup/presentation/bloc/signup_event.dart';
import '../../../../signup/presentation/bloc/signup_state.dart';

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
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }

        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account Created Successfully")),
          );

          widget.onLoginClicked();
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
                color: const Color(0xff94A3B8),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff94A3B8),
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color(0xff94A3B8),
                size: 25.sp,
                fontWeight: FontWeight.bold,
              ),
        
              fillColor: Color(0xffF8FAFC),
              borderColor: Color(0xff94A3B8),
              radius: 8,
        
              textFieldTitle: "Full Name",
              hintText: "Enter your full name",
        
              keyBoardType: TextInputType.name,
            ),
        
            const HeightSpace(height: 16),
        
            /// Email
            CustomTextField(
              controller: _emailController,
              validator: (value) => ConstantValidate().validateEmail(value ?? ''),
              hintTextStyle: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xff94A3B8),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff94A3B8),
              ),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Color(0xff94A3B8),
                size: 25.sp,
                fontWeight: FontWeight.bold,
              ),
        
              fillColor: Color(0xffF8FAFC),
              borderColor: Color(0xff94A3B8),
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
                color: const Color(0xff94A3B8),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff94A3B8),
              ),
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: Color(0xff94A3B8),
                size: 25.sp,
                fontWeight: FontWeight.bold,
              ),
        
              fillColor: Color(0xffF8FAFC),
              borderColor: Color(0xff94A3B8),
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
                color: const Color(0xff94A3B8),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff94A3B8),
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Color(0xff94A3B8),
                size: 25.sp,
              ),
        
              fillColor: Color(0xffF8FAFC),
              borderColor: Color(0xff94A3B8),
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
                color: const Color(0xff94A3B8),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Color(0xff94A3B8),
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Color(0xff94A3B8),
                size: 25.sp,
              ),
        
              fillColor: Color(0xffF8FAFC),
              borderColor: Color(0xff94A3B8),
              radius: 8,
        
              textFieldTitle: "Confirm Password",
              hintText: "Re-enter your password",
        
              keyBoardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            const HeightSpace(height: 16),
        
            const CustomTermsAndPrivacy(),
        
            const HeightSpace(height: 20),
        
            /// Create Account Button
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: state.isLoading
                        ? null
                        : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignUpBloc>().add(
                              SignUpButtonPressed(
                                fullName: _fullNameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                    child: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
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
