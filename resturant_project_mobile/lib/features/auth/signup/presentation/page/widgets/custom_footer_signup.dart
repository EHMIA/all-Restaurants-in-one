import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/widgets/spacing_widgets.dart';

class CustomFooterSignup extends StatelessWidget {
  const CustomFooterSignup({super.key, required this.onLoginClicked});
  final VoidCallback? onLoginClicked;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeightSpace(height: 20),

        /// Login link
        Center(
          child: Text.rich(
            TextSpan(
              text: "Already have an account? ",
              children: [
                TextSpan(
                  text: "Login",
                  style: const TextStyle(color: AppColors.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = onLoginClicked,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}