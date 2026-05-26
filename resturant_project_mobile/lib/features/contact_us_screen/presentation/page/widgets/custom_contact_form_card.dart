import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/widgets/custom_snack_bar.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import '../../cubit/contact_us_cubit.dart';
import '../../cubit/contact_us_state.dart';
import 'custom_input_label.dart';
import 'custom_text_field.dart';

class ContactFormCard extends StatefulWidget {
  const ContactFormCard();

  @override
  State<ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<ContactFormCard> {
  bool _agreed = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_nameController.text.isEmpty) {
      CustomSnackBar.show(context, message: 'Please enter your name');
      return;
    }
    if (_emailController.text.isEmpty) {
      CustomSnackBar.show(context, message: 'Please enter your email');
      return;
    }
    if (!_isValidEmail(_emailController.text)) {
      CustomSnackBar.show(context, message: 'Please enter a valid email');
      return;
    }
    if (_messageController.text.isEmpty) {
      CustomSnackBar.show(context, message: 'Please enter your message');
      return;
    }
    if (!_agreed) {
      CustomSnackBar.show(
        context,
        message: 'Please agree to the Privacy Policy',
      );
      return;
    }

    context.read<ContactCubit>().submitMessage(
      name: _nameController.text,
      email: _emailController.text,
      message: _messageController.text,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactCubit, ContactState>(
      listener: (context, state) {
        if (state is ContactSuccess) {
          CustomSnackBar.show(
            context,
            message: state.message ?? 'Message sent successfully!',
            backgroundColor: AppColors.snackBarSuccessColor,
          );
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          setState(() => _agreed = false);
        } else if (state is ContactError) {
          CustomSnackBar.show(
            context,
            message: state.error,
            backgroundColor: AppColors.snackBarErrorColor,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomInputLabel(label: 'Full Name'),
            CustomTextField(
              hint: 'Enter your name',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            const CustomInputLabel(label: 'Email Address'),
            CustomTextField(
              hint: 'example@mail.com',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            const CustomInputLabel(label: 'Message'),
            CustomTextField(
              hint: 'How can we help you?',
              maxLines: 4,
              controller: _messageController,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  activeColor: const Color(0xFFE53935),
                  onChanged: (v) => setState(() => _agreed = v!),
                ),
                const Text('I agree to the ', style: TextStyle(fontSize: 14)),
                const Text(
                  'Privacy Policy',
                  style: TextStyle(color: Color(0xFFE53935), fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<ContactCubit, ContactState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53935),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: state is ContactLoading ? null : _submitForm,
                    child: state is ContactLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Send Message',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
