import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/features/auth/signup/presentation/page/widgets/custom_footer_signup.dart';
import 'package:resturant_project/core/constants/constant_validate.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import '../../../auth_route/cubit/auth_route_cubit.dart';
import '../cubit/signup_cubit.dart';
import '../cubit/signup_state.dart';
import 'widgets/custom_sign_up_text_field.dart';
import 'widgets/custom_sign_up_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.onLoginClicked});
  final VoidCallback onLoginClicked;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<SignUpCubit>().signUp(
        _emailController.text,
        _fullNameController.text,
        _passwordController.text,
        _confirmPasswordController.text,
        _phoneController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          CustomSnackBar.show(
            context,
            message: state.errorMessage,
            backgroundColor: AppColors.snackBarErrorColor,
          );
        }
        if (state is SignUpSuccess) {
          CustomSnackBar.show(
            context,
            message: "Account Created Successfully",
            backgroundColor: AppColors.snackBarSuccessColor,
          );
          context.read<AuthRouteCubit>().selectLoginTab();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightSpace(height: 16),

            CustomSignUpTextField(
              controller: _fullNameController,
              textFieldTitle: "Full Name",
              hintText: "Enter your full name",
              prefixIcon: Icons.person_outline,
              keyBoardType: TextInputType.name,
            ),
            const HeightSpace(height: 16),

            CustomSignUpTextField(
              controller: _emailController,
              textFieldTitle: "Email",
              hintText: "Enter your email",
              prefixIcon: Icons.email_outlined,
              keyBoardType: TextInputType.emailAddress,
              validator: (value) =>
                  ConstantValidate().validateEmail(value ?? ''),
            ),
            const HeightSpace(height: 16),

            CustomSignUpTextField(
              controller: _phoneController,
              textFieldTitle: "Phone",
              hintText: "Enter your phone number",
              prefixIcon: Icons.phone_outlined,
              keyBoardType: TextInputType.phone,
            ),
            const HeightSpace(height: 16),

            CustomSignUpTextField(
              controller: _passwordController,
              textFieldTitle: "Password",
              hintText: "Enter your password",
              prefixIcon: Icons.lock_outline,
              keyBoardType: TextInputType.visiblePassword,
              isPassword: true,
              validator: (value) =>
                  ConstantValidate().validatePassword(value ?? ''),
            ),
            const HeightSpace(height: 16),

            CustomSignUpTextField(
              controller: _confirmPasswordController,
              textFieldTitle: "Confirm Password",
              hintText: "Re-enter your password",
              prefixIcon: Icons.lock_outline,
              keyBoardType: TextInputType.visiblePassword,
              isPassword: true,
              validator: (value) => value != _passwordController.text
                  ? 'Passwords do not match'
                  : null,
            ),
            const HeightSpace(height: 36),

            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return CustomSignUpButton(
                  isLoading: state is SignUpLoading,
                  onPressed: () => _handleSignUp(context),
                );
              },
            ),

            CustomFooterSignup(onLoginClicked: widget.onLoginClicked),
          ],
        ),
      ),
    );
  }
}
