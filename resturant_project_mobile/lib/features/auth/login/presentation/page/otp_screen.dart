import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/features/auth/login/data/repository/otp_repo.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/otp_cubit.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/otp_state.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/custom_otp_verify_button.dart';
import 'widgets/custom_otp_header.dart';
import 'widgets/custom_otp_pin_input.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationToken});
  final String verificationToken;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _handleVerifyOtp(BuildContext context) {
    String otp = _pinController.text;
    if (otp.length != 6) {
      CustomSnackBar.show(
        context,
        message: "Please enter a valid 6-digit OTP",
        backgroundColor: AppColors.primaryColor,
      );
      return;
    }
    context.read<OtpCubit>().verifyOtp(otp, widget.verificationToken);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        otpRepo: OtpRepo(api: DioConsumer(dio: Dio())),
      ),
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            backgroundColor: AppColors.backgoroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.textBlackColor,
                  size: 28.sp,
                ),
                onPressed: () => GoRouter.of(context).pop(),
              ),
            ),
            body: BlocListener<OtpCubit, OtpState>(
              listener: (context, state) {
                if (state is OtpFailure) {
                  CustomSnackBar.show(
                    context,
                    message: state.errorMessage,
                    backgroundColor: AppColors.snackBarErrorColor,
                  );
                }
                if (state is OtpSuccess) {
                  CustomSnackBar.show(
                    context,
                    message: state.message,
                    backgroundColor: AppColors.snackBarSuccessColor,
                  );
                  GoRouter.of(context).pushNamed(
                    RouteName.resetPasswordScreen,
                    extra: {"resetToken": state.resetToken},
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(24.sp),
                    decoration: _buildBoxDecoration(),
                    child: Column(
                      children: [
                        const CustomOtpHeader(),
                        const HeightSpace(height: 48),
                        CustomOtpPinInput(controller: _pinController),
                        const HeightSpace(height: 40),
                        CustomOtpVerifyButton(
                          onTap: () => _handleVerifyOtp(innerContext),
                        ),
                        const HeightSpace(height: 20),
                        // CustomOtpResendSection(
                        //   onResendTap: () {
                        //     //code here
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: AppColors.containerWhiteColor,
      borderRadius: BorderRadius.circular(30.r),
      boxShadow: [
        BoxShadow(
          spreadRadius: 5,
          blurRadius: 15,
          color: AppColors.shadowColor,
        ),
      ],
    );
  }
}
