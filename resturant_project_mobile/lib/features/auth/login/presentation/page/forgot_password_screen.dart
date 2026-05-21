import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/constants/constant_validate.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_footer_forgot_password.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_logo_title_subtitle_forgot_password.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import '../../data/repository/forget_password_repo.dart';
import '../cubit/forget_password_cubit.dart';
import '../cubit/forget_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        forgetRepo: ForgetPasswordRepo(api: DioConsumer(dio: Dio())),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
          body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordSuccess) {
                CustomSnackBar.show(
                  context,
                  message: state.message,
                  backgroundColor: AppColors.snackBarSuccessColor,
                );
                GoRouter.of(context).pushNamed(
                  RouteName.otpScreen,
                  extra: {"email": _emailController.text,"verificationToken": state.verificationToken},
                );
              } else if (state is ForgotPasswordFailure) {
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
                  bottom: false,
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
                            CustomLogoTitleSubtitleForgotPassword(),
                            CustomTextField(
                              controller: _emailController,
                              textFieldTitle: "Email",
                              hintText: "e.g. name@email.com",
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
                                fontWeight: FontWeight.bold,
                              ),

                              fillColor: AppColors.textFormFillColor,
                              borderColor: AppColors.textFormFieldColor,
                              radius: 8,
                            ),
                            const HeightSpace(height: 32),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state is ForgotPasswordLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          context
                                              .read<ForgotPasswordCubit>()
                                              .sendOtp(_emailController.text);
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
                                        color: AppColors.textWhiteColor,
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
                                              color: AppColors.textWhiteColor,
                                            ),
                                          ),
                                          const WidthSpace(width: 8),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.textWhiteColor,
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
