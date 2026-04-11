import 'package:resturant_project/core/api/end_points.dart';

class ForgetPasswordModel {
  final String message;
  final String otp;
  final String email;
  final String userId;

  ForgetPasswordModel({
    required this.message,
    required this.otp,
    required this.email,
    required this.userId,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      message: json[ApiKey.forgetMessage],
      otp: json[ApiKey.otp],
      email: json[ApiKey.email],
      userId: json[ApiKey.userId],
    );
  }
}
