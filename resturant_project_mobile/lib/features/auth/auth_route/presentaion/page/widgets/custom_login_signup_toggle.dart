import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../bloc/auth_route_bloc.dart';
import '../../bloc/auth_route_event.dart';
import '../../bloc/auth_route_state.dart';

class CustomLoginSignupToggle extends StatelessWidget {
  const CustomLoginSignupToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthRouteBloc, AuthRouteState>(
      builder: (context, state) {
        return Container(
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
                  onTap: () => context.read<AuthRouteBloc>().add(TapLoginTab()),
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

              const WidthSpace(width: 4),

              /// Sign Up
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      context.read<AuthRouteBloc>().add(TapSignUpTab()),
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
        );
      },
    );
  }
}
