import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:resturant_project/features/auth/login/presentation/page/login_screen.dart';
import 'package:resturant_project/features/auth/signup/presentation/bloc/sign_up_bloc.dart';
import 'package:resturant_project/features/auth/signup/presentation/page/sign_up_page.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';

class AuthRouteScreen extends StatefulWidget {
  const AuthRouteScreen({super.key});

  @override
  State<AuthRouteScreen> createState() => _AuthRouteScreenState();
}

class _AuthRouteScreenState extends State<AuthRouteScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  /// Logo
                  HeightSpace(height: 32),
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: Colors.red.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.red,
                      size: 35.sp,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Title
                  Text(
                    "Akiel",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Subtitle
                  Text(
                    "Welcome! Login or Create an Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff64748B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 🔥 Tabs
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        /// Login
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (selectedIndex != 0) {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              }
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.all(4.sp),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: selectedIndex == 0
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 4),

                        /// Sign Up
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (selectedIndex != 1) {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              }
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.all(4.sp),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: selectedIndex == 1
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  ///  Animated Forms (FIXED)
                  SizedBox(
                    width: double.infinity,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),

                      transitionBuilder: (child, animation) {
                        final isLogin = child.key == const ValueKey("login");

                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(isLogin ? -1 : 1, 0),
                            end: const Offset(0, 0),
                          ).animate(animation),
                          child: child,
                        );
                      },

                      child: selectedIndex == 0
                          ? BlocProvider(
                              create: (context) => LoginBloc(),
                              child: BlocProvider(
                                create: (context) => LoginBloc(),
                                child: LoginScreen(
                                  key: const ValueKey("login"),
                                  onSignUpClicked: () {
                                    setState(() {
                                      selectedIndex = 1;
                                    });
                                  },
                                ),
                              ),
                            )
                          : BlocProvider(
                              create: (context) => SignUpBloc(),
                              child: BlocProvider(
                                create: (context) => SignUpBloc(),
                                child: SignUpPage(
                                  key: const ValueKey("signup"),
                                  onLoginClicked: () {
                                    setState(() {
                                      selectedIndex = 0;
                                    });
                                  },
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
