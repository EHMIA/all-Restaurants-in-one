import 'package:resturant_project/core/api/end_points.dart';

class ForgetPasswordModel {
  final String message;
  final String otp;
  final String? verificationToken; 

  ForgetPasswordModel({
    required this.message,
    required this.otp,
    this.verificationToken,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      message: json['message'] ?? '',
      otp: json['otp']?.toString() ?? '',
      verificationToken: json['verificationToken'],
    );
  }
}
