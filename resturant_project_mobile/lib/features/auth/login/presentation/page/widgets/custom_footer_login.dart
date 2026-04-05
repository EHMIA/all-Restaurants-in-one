import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/widgets/spacing_widgets.dart';

class CustomFooterLogin extends StatelessWidget {
  const CustomFooterLogin({super.key, required this.onSignUpClicked});
  final VoidCallback onSignUpClicked ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeightSpace(height: 25),
        Text.rich(
          TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xff64748B),
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: "Sign Up Free",
                style: TextStyle(color: AppColors.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = onSignUpClicked,
              ),
            ],
          ),
        ),
      ],
    );
  }
}