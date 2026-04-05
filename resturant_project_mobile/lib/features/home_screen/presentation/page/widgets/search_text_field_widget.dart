import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/widgets/custom_text_field.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            validator: widget.validator,
            controller: widget.controller,
            radius: 35.r,
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: Color(0xff94A3B8),
              size: 23.sp,
            ),
            hintText: widget.hintText, //"Search dishes...",
          ),
        ),
      ],
    );
  }
}
