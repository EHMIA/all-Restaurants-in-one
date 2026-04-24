import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/features/auth/login/data/repository/forget_password_repo.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/forget_password_cubit.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/login_state.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_footer_login.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_login_forget_password.dart';
import 'package:resturant_project/core/constants/constant_validate.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

import '../cubit/login_cubit.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
// @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final token = await StorageHelper.getToken();
//       if (token != null && token.isNotEmpty) {
//         if (mounted) {
//           GoRouter.of(context).pushReplacementNamed(RouteName.layOutScreen);
//         }
//       }
//     });
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          CustomSnackBar.show(context, message: state.errorMessage, backgroundColor: AppColors.primaryColor);
        } else if (state is LoginSuccess) {
          CustomSnackBar.show(context, message: "Login successful!", backgroundColor: Colors.green);
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
            BlocProvider(
              create: (context) => ForgotPasswordCubit(
                forgetRepo: ForgetPasswordRepo(api: DioConsumer(dio: Dio())),
              ),
              child: const CustomLoginForgetPassword(),
            ),

            const HeightSpace(height: 20),

            /// Login Button
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<LoginCubit>().login(
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                    child: state is LoginLoading
                        ? const CircularProgressIndicator(color: Colors.white)
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
