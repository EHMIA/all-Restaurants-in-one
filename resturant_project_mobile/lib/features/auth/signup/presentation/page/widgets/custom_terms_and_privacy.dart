import 'package:flutter/material.dart';
import 'package:resturant_project/core/styles/app_colors.dart';

class CustomTermsAndPrivacy extends StatelessWidget {
  const CustomTermsAndPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Checkbox(value: false, onChanged: (v) {}),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "I agree to the ",
                      children: [
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
  }
}