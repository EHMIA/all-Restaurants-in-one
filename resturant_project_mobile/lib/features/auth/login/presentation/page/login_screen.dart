import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/auth/login/presentation/bloc/login_state.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/widgets_login/custom_footer_login.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/widgets_login/custom_login_forget_password.dart';
import 'package:resturant_project/features/core/constants/constant_validate.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onSignUpClicked});
  final VoidCallback onSignUpClicked;
  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        } else if (!state.isLoading) {
          GoRouter.of(context).goNamed(RouteName.layOutScreen);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HeightSpace(height: 24),

            /// Email
            CustomTextField(
              controller: _emailController,
              validator: (value) =>
                  ConstantValidate().validateEmail(value ?? ''),
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

            const HeightSpace(height: 20),

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

              isPassword: true,
            ),
            const HeightSpace(height: 15),

            /// Remember me
            const CustomLoginForgetPassword(),

            const HeightSpace(height: 20),

            /// Login Button
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    onPressed: state.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                    child: state.isLoading
                        ?const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  );
                },
              ),
            ),

            CustomFooterLogin(onSignUpClicked: widget.onSignUpClicked),
          ],
        ),
      ),
    );
  }
}
