import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/features/auth/auth_route/presentaion/page/widgets/custom_login_signup_toggle.dart';
import 'package:resturant_project/features/auth/auth_route/presentaion/page/widgets/cutom_logo_title_subtitle.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

import '../cubit/auth_route_cubit.dart';
import 'widgets/custom_auth_switcher_body.dart';

class AuthRouteScreen extends StatefulWidget {
  const AuthRouteScreen({super.key});

  @override
  State<AuthRouteScreen> createState() => _AuthRouteScreenState();
}

class _AuthRouteScreenState extends State<AuthRouteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthRouteCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor:  AppColors.backgoroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 33.sp),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CutomLogoTitleSubtitle(),
        
                      CustomLoginSignupToggle(),
        
                      HeightSpace(height: 24),
        
                      CustomAuthSwitcherBody(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
