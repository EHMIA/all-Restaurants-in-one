import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_text_field.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/contact_us_screen/presentation/cubit/contact_us_cubit.dart';
import 'package:resturant_project/features/contact_us_screen/presentation/cubit/contact_us_state.dart';
import 'package:resturant_project/features/contact_us_screen/presentation/page/widgets/custom_head_section.dart';
import 'package:resturant_project/features/profile_screen/data/repository/edit_profile_repo.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/change_password_cubit.dart';
import '../../../../../core/constants/constant_validate.dart';
import '../../data/repository/contact_us_repo.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleChangePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ContactCubit>().submitMessage(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit(
        contactUsRepo: ContactUsRepo(api: DioConsumer(dio: Dio())),
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgoroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textBlackColor,
              size: 28.sp,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<ContactCubit, ContactState>(
          listener: (context, state) {
            if (state is ContactSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.snackBarSuccessColor,
                  duration: const Duration(seconds: 2),
                ),
              );
            }

            if (state is ContactError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: AppColors.snackBarErrorColor,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
            if (state is ContactSuccess) {
              CustomSnackBar.show(
                context,
                message: state.message,
                backgroundColor: AppColors.snackBarSuccessColor,
              );
              GoRouter.of(context).pop();
            } else if (state is ContactError) {
              CustomSnackBar.show(
                context,
                message: state.error,
                backgroundColor: AppColors.snackBarErrorColor,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(24.sp),
                    decoration: BoxDecoration(
                      color: AppColors.containerWhiteColor,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5.r,
                          blurRadius: 15.r,
                          color: AppColors.shadowColor,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeightSpace(height: 20),
                          HeaderSection(),
                          const HeightSpace(height: 40),
                          CustomTextField(
                            controller: _nameController,
                            hintTextStyle: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textFormFieldColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: AppColors.textFormFieldColor,
                            ),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.textFormFieldColor,
                              size: 25.sp,
                            ),

                            fillColor: Color(0xffF8FAFC),
                            borderColor: AppColors.textFormFieldColor,
                            radius: 8,

                            textFieldTitle: "Name",
                            hintText: "Enter your current name",

                            isPassword: false,
                          ),
                          HeightSpace(height: 15),
                          CustomTextField(
                            controller: _emailController,
                            validator: (value) => ConstantValidate()
                                .validateEmail(value ?? ''),
                            hintTextStyle: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textFormFieldColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: AppColors.textFormFieldColor,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.textFormFieldColor,
                              size: 25.sp,
                            ),

                            fillColor: Color(0xffF8FAFC),
                            borderColor: AppColors.textFormFieldColor,
                            radius: 8,

                            textFieldTitle: "Email",
                            hintText: "Enter your email",

                            isPassword: false,
                          ),
                          HeightSpace(height: 15),

                          //const CustomPasswordRequirementsChangePassword(),
                          CustomTextField(
                            controller: _messageController,
                            hintText:
                                "What we can help you, Write what you want",
                            maxLines: 9,
                            hintTextStyle: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xff94A3B8),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            ),
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: Color(0xff94A3B8),
                            ),
                            fillColor: Color(0xffF8FAFC),
                            borderColor: Color(0xff94A3B8),
                            radius: 16,
                          ),
                          const HeightSpace(height: 32),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is ContactLoading
                                  ? null
                                  : () => _handleChangePassword(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: state is ContactLoading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.textWhiteColor,
                                    )
                                  : Text(
                                      "Submit",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textWhiteColor,
                                      ),
                                    ),
                            ),
                          ),

                          const HeightSpace(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
