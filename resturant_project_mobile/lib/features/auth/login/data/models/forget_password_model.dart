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
      message: json[ApiKey.forgetMessage] ?? '',
      otp: json[ApiKey.otp]?.toString() ?? '',
      verificationToken: json[ApiKey.verificationToken],
    );
  }
}
