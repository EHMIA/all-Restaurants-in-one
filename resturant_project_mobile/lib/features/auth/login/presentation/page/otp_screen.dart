import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:resturant_project/features/auth/login/presentation/bloc/otp_bloc.dart';
import 'package:resturant_project/features/auth/login/presentation/bloc/otp_event.dart';
import 'package:resturant_project/features/auth/login/presentation/bloc/otp_state.dart';
import 'package:resturant_project/features/core/app_assets/app_assets.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  late OtpBloc _otpBloc;

  @override
  void initState() {
    super.initState();
    _otpBloc = OtpBloc();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _otpBloc.close();
    super.dispose();
  }

  void _handleVerifyOtp() {
    String otp = _pinController.text;

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP must be 6 digits'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _otpBloc.add(OtpVerifyButtonPressed(otp: otp, email: widget.email));
  }

  void _handleResendOtp() {
    _pinController.clear();
    _otpBloc.add(OtpResendButtonPressed(email: widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      backgroundColor: Color(0xffFFF8F0),
      body: BlocListener<OtpBloc, OtpState>(
        bloc: _otpBloc,
        listener: (context, state) {
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }

          if (state.isOtpVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP verified successfully!'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to reset password after a short delay
            Future.delayed(Duration(seconds: 1), () {
              if (mounted) {
                GoRouter.of(context).goNamed(RouteName.resetPasswordPage);
              }
            });
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Logo Section
                    const HeightSpace(height: 40),

                    /// Logo Icon
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: SvgPicture.asset(AppAssets.logo),
                    ),

                    const HeightSpace(height: 16),

                    /// App Name
                    Text(
                      "Akiel",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                        color: AppColors.primaryColor,
                      ),
                    ),

                    const HeightSpace(height: 24),

                    /// Title
                    Text(
                      "Verify OTP",
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                        color: AppColors.primaryColor,
                      ),
                    ),

                    const HeightSpace(height: 16),

                    /// Description
                    SizedBox(
                      width: 280.w,
                      child: Text(
                        'We\'ve sent a 6-digit code to ${widget.email}\nEnter the code below to verify your identity.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          color: Color(0xff64748B),
                          height: 1.4,
                        ),
                      ),
                    ),

                    const HeightSpace(height: 48),

                    /// OTP Input Field
                    BlocBuilder<OtpBloc, OtpState>(
                      bloc: _otpBloc,
                      builder: (context, state) {
                        return Pinput(
                          controller: _pinController,
                          length: 6,
                          showCursor: true,
                          onCompleted: (pin) {},
                          defaultPinTheme: PinTheme(
                            width: 50.w,
                            height: 50.h,
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: AppColors.primaryColor,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffF8FAFC),
                              border: Border.all(
                                color: Color(0xff94A3B8),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 50.w,
                            height: 50.h,
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: AppColors.primaryColor,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: 50.w,
                            height: 50.h,
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: AppColors.primaryColor,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          errorPinTheme: PinTheme(
                            width: 50.w,
                            height: 50.h,
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: Colors.red,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              border: Border.all(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        );
                      },
                    ),

                    const HeightSpace(height: 40),

                    /// Verify Button
                    BlocBuilder<OtpBloc, OtpState>(
                      bloc: _otpBloc,
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: state.isLoading ? null : _handleVerifyOtp,
                          child: Container(
                            width: double.infinity,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: state.isLoading
                                  ? AppColors.primaryColor.withValues(
                                      alpha: 0.6,
                                    )
                                  : AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: state.isLoading
                                  ? SizedBox(
                                      width: 24.sp,
                                      height: 24.sp,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                        strokeWidth: 2.sp,
                                      ),
                                    )
                                  : Text(
                                      "Verify OTP",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),

                    const HeightSpace(height: 20),

                    /// Resend OTP Section
                    BlocBuilder<OtpBloc, OtpState>(
                      bloc: _otpBloc,
                      builder: (context, state) {
                        return Column(
                          children: [
                            Text(
                              "Didn't receive the code?",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                color: Color(0xff64748B),
                              ),
                            ),
                            const HeightSpace(height: 8),
                            if (state.canResend)
                              GestureDetector(
                                onTap: _handleResendOtp,
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            else
                              Text(
                                "Resend in ${state.resendCountdown}s",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Color(0xff94A3B8),
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    const HeightSpace(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
