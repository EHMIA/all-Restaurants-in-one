import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../cubit/auth_route_cubit.dart';
import '../../cubit/auth_route_state.dart';

class CustomLoginSignupToggle extends StatelessWidget {
  const CustomLoginSignupToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthRouteCubit, AuthRouteState>(
      builder: (context, state) {
        return Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.textGrayColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              //login
              Expanded(
                child: GestureDetector(
                  onTap: () => context.read<AuthRouteCubit>().selectLoginTab(),
                  child: AnimatedContainer(
                    margin: EdgeInsets.all(4.sp),
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: state.selectedIndex == 0
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: state.selectedIndex == 0
                            ? AppColors.textWhiteColor
                            : AppColors.textGrayColor.withValues(alpha: 0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ),

              const WidthSpace(width: 4),
              //sign up
              Expanded(
                child: GestureDetector(
                  onTap: () => context.read<AuthRouteCubit>().selectSignUpTab(),
                  child: AnimatedContainer(
                    margin: EdgeInsets.all(4.sp),
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: state.selectedIndex == 1
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: state.selectedIndex == 1
                            ? AppColors.textWhiteColor
                            : AppColors.textGrayColor.withValues(alpha: 0.7),
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
        );
      },
    );
  }
}
