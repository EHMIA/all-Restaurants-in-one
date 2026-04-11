import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/features/auth/login/data/repository/otp_repo.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/otp_cubit.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/otp_state.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String otp;

  const OtpScreen({super.key, required this.email, required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  late OtpCubit _otpCubit;

  @override
  void initState() {
    super.initState();
    _otpCubit = OtpCubit(
      otpRepo: OtpRepo(api: DioConsumer(dio: Dio())),
    );
    _pinController.text = widget.otp;
  }

  @override
  void dispose() {
    _pinController.dispose();
    _otpCubit.close();
    super.dispose();
  }

  void _handleVerifyOtp() {
    String otp = _pinController.text;
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP must be 6 digits'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    _otpCubit.verifyOtp(widget.email, otp);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(otpRepo: OtpRepo(api: DioConsumer(dio: Dio()))),
      child: Scaffold(
        backgroundColor: const Color(0xffFFF8F0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 28.sp),
            onPressed: () => GoRouter.of(context).pop(),
          ),
        ),
        body: BlocListener<OtpCubit, OtpState>(
          bloc: _otpCubit,
          listener: (context, state) {
            if (state is OtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is OtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              GoRouter.of(context).goNamed(RouteName.resetPasswordPage);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Container(
                padding: EdgeInsets.all(24.sp),
                decoration: _buildBoxDecoration(),
                child: Column(
                  children: [
                    _buildHeader(),
                    const HeightSpace(height: 48),
                    _buildOtpInput(),
                    const HeightSpace(height: 40),
                    _buildVerifyButton(),
                    const HeightSpace(height: 20),
                    _buildResendSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //!============================================================================
  Widget _buildOtpInput() {
    return Pinput(
      controller: _pinController,
      length: 6,
      defaultPinTheme: PinTheme(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color(0xffF8FAFC),
          border: Border.all(color: const Color(0xff94A3B8)),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return BlocBuilder<OtpCubit, OtpState>(
      bloc: _otpCubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: state is OtpLoading ? null : _handleVerifyOtp,
          child: Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: state is OtpLoading
                  ? AppColors.primaryColor.withValues(alpha:0.6)
                  : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: state is OtpLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Verify OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResendSection() {
    return Column(
      children: [
        Text(
          "Didn't receive the code?",
          style: TextStyle(color: const Color(0xff64748B), fontSize: 14.sp),
        ),
        const HeightSpace(height: 8),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Resend OTP",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.r),
      boxShadow: [
        BoxShadow(
          spreadRadius: 5,
          blurRadius: 15,
          color: Colors.black.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const HeightSpace(height: 40),
        SvgPicture.asset(AppAssets.logo, width: 70.w, height: 70.h),
        const HeightSpace(height: 16),
        Text(
          "Akiel",
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const HeightSpace(height: 24),
        Text(
          "Verify OTP",
          style: TextStyle(
            fontSize: 28.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
