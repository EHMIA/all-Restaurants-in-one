import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.keyBoardType,
    this.validator,
    this.hintText,
    this.textFieldTitle,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.radius,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.fillColor,
    this.borderColor,
    this.cursorColor,
    this.textStyle,
    this.hintTextStyle,
  });

  final String? textFieldTitle;
  final TextEditingController? controller;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? prefixIcon;
  final String? suffixIcon;
  final bool isPassword;
  final double? radius;
  final int? maxLines;
  final void Function(String)? onFieldSubmitted;
  final Color? fillColor;
  final Color? borderColor;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.textFieldTitle != null)
          Row(
            children: [
              Text(
                widget.textFieldTitle!,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: const Color(0xff334155),
                ),
              ),
            ],
          ),
        if (widget.textFieldTitle != null) HeightSpace(height: 3),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyBoardType,
          validator: widget.validator,
          maxLines: widget.maxLines,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: widget.isPassword && !isPasswordVisible,
          obscuringCharacter: '●',
          cursorColor: widget.cursorColor ?? Color(0xff94A3B8),
          cursorWidth: 2.w,
          cursorErrorColor: Colors.red,
          style: widget.textStyle,
          decoration: InputDecoration(
            hintText: widget.hintText ?? '',
            hintStyle: widget.hintTextStyle,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ),
            filled: true,
            fillColor: widget.fillColor ?? Colors.white,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xff94A3B8),
                        size: 25.sp,
                      ),
                    ),
                  )
                : widget.suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      widget.suffixIcon!,
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius?.r ?? 18.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius?.r ?? 18.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius?.r ?? 18.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 10.sp,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius?.r ?? 18.r),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
