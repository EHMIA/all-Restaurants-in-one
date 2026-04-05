import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/widgets_auth_route/custom_login_signup_toggle.dart';
import 'package:resturant_project/features/auth/login/presentation/page/widgets/widgets_auth_route/cutom_logo_title_subtitle.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

import 'login/presentation/bloc/auth_route_bloc.dart';
import 'login/presentation/page/widgets/widgets_auth_route/custom_auth_switcher_body.dart';

class AuthRouteScreen extends StatefulWidget {
  const AuthRouteScreen({super.key});

  @override
  State<AuthRouteScreen> createState() => _AuthRouteScreenState();
}

class _AuthRouteScreenState extends State<AuthRouteScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthRouteBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xffFFF8F0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 33.sp),
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
                    const CutomLogoTitleSubtitle(),

                    const CustomLoginSignupToggle(),

                    const HeightSpace(height: 24),

                    const CustomAuthSwitcherBody(),
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
