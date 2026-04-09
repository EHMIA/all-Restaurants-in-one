import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/app_assets/app_assets.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _textAnimationController;
  late AnimationController _containerAnimationController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logicOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _containerScaleAnimation;

  @override
  void initState() {
    super.initState();

    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _containerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _logicOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeIn),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textAnimationController, curve: Curves.easeIn),
    );

    _containerScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _containerAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _startAnimations();
    checkLogin();
  }


  // ======================================simulate checking login status====================================================
  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    //await Future.delayed(Duration(seconds: 2));

    if (isLoggedIn) {
     GoRouter.of(context).goNamed(RouteName.layOutScreen);
    } else {
      GoRouter.of(context).goNamed(RouteName.signInPage);
    }
  }

  void _startAnimations() {
    _containerAnimationController.forward();
    _logoAnimationController.forward().then((_) {
      _textAnimationController.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.goNamed(RouteName.layOutScreen);
      }
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    _containerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -50,
            child: ScaleTransition(
              scale: _containerScaleAnimation,
              child: Container(
                width: 300.w,
                height: 300.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: ScaleTransition(
              scale: _containerScaleAnimation,
              child: Container(
                width: 250.w,
                height: 250.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha:0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: FadeTransition(
                    opacity: _logicOpacityAnimation,
                    child: SvgPicture.asset(
                      AppAssets.logo,
                      width: 120.w,
                      height: 120.h,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                SlideTransition(
                  position: _textSlideAnimation,
                  child: FadeTransition(
                    opacity: _textOpacityAnimation,
                    child: Column(
                      children: [
                        Text(
                          'Akiel',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor.withValues(alpha:0.6),
                            ],
                          ).createShader(bounds),
                          child: Text(
                            'Discover Great Food',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _textOpacityAnimation,
              child: Center(
                child: SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor.withValues(alpha:0.7),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
