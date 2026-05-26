// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../../core/styles/app_colors.dart';
// import '../../cubit/edit_profile_cubit.dart';

// class EditProfileChangePasswordDialog extends StatefulWidget {
//   const EditProfileChangePasswordDialog({super.key});

//   static void show(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (dialogContext) => BlocProvider.value(
//         value: context.read<EditProfileCubit>(),
//         child: const EditProfileChangePasswordDialog(),
//       ),
//     );
//   }

//   @override
//   State<EditProfileChangePasswordDialog> createState() =>
//       _EditProfileChangePasswordDialogState();
// }

// class _EditProfileChangePasswordDialogState
//     extends State<EditProfileChangePasswordDialog> {
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   InputDecoration _fieldDecoration(String label) => InputDecoration(
//     labelText: label,
//     filled: true,
//     fillColor: const Color(0xffF8FAFC),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12.r),
//       borderSide: const BorderSide(color: Color(0xffE8EAED)),
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       title: Center(
//         child: Text(
//           'Change Password',
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Poppins',
//           ),
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _currentPasswordController,
//               obscureText: true,
//               decoration: _fieldDecoration('Current Password'),
//             ),
//             SizedBox(height: 16.h),
//             TextField(
//               controller: _newPasswordController,
//               obscureText: true,
//               decoration: _fieldDecoration('New Password'),
//             ),
//             SizedBox(height: 16.h),
//             TextField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               decoration: _fieldDecoration('Confirm Password'),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text(
//             'Cancel',
//             style: TextStyle(color: AppColors.grayColor, fontFamily: 'Poppins'),
//           ),
//         ),
//         TextButton(
//           onPressed: _onUpdate,
//           child: Text(
//             'Update',
//             style: TextStyle(
//               color: AppColors.primaryColor,
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _onUpdate() {
//     if (_currentPasswordController.text.isEmpty ||
//         _newPasswordController.text.isEmpty ||
//         _confirmPasswordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('All fields are required'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     context.read<EditProfileCubit>().updatePassword(
//       currentPassword: _currentPasswordController.text,
//       newPassword: _newPasswordController.text,
//       confirmPassword: _confirmPasswordController.text,
//     );

//     Navigator.pop(context);
//   }
// }
