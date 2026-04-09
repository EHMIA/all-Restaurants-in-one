import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routing/route_name.dart';
import '../../../../../../core/styles/app_colors.dart';

class CustomLoginForgetPassword extends StatelessWidget {
  const CustomLoginForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),

        GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(RouteName.forgotPasswordPage);
          },

          child: Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
