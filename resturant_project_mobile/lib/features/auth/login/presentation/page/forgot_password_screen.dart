import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_footer_forgot_password.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_logo_title_subtitle_forgot_password.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import '../bloc/forget_password_bloc.dart';
import '../bloc/forget_password_event.dart';
import '../bloc/forget_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailPhoneController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  String? validateEmailOrPhone(String emailOrPhone) {
    if (emailOrPhone.isEmpty) return 'Email or phone number cannot be empty';
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    final phoneRegex = RegExp(r'^[0-9\+\-\s\(\)]{10,}$');
    if (!emailRegex.hasMatch(emailOrPhone) &&
        !phoneRegex.hasMatch(emailOrPhone)) {
      return 'Please enter a valid email or phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xffFFF8F0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              GoRouter.of(context).pushNamed(
                RouteName.otpPage,
                extra: _emailPhoneController.text,
              );
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(24.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5.r,
                          blurRadius: 15.r,
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLogoTitleSubtitleForgotPassword(),
                          CustomTextField(
                            controller: _emailPhoneController,
                            validator: (value) =>
                                validateEmailOrPhone(value ?? ''),
                            textFieldTitle: "Email or Phone Number",
                            hintText: "e.g. name@email.com",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: const Color(0xff94A3B8),
                              size: 25.sp,
                            ),
                          ),
                          const HeightSpace(height: 32),
                          
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is ForgotPasswordLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<ForgotPasswordBloc>().add(
                                          SendOtpEvent(
                                            emailOrPhone:
                                                _emailPhoneController.text,
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: state is ForgotPasswordLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Send OTP",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                          ),
                                        ),
                                        const WidthSpace(width: 8),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          CustomFooterForgotPassword(),
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
    _emailPhoneController.dispose();
    super.dispose();
  }
}
