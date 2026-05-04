import 'package:resturant_project/core/api/end_points.dart';

class OtpModel {
  final String message;
  final String? resetToken;

  OtpModel({required this.message, this.resetToken});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      message: json[ApiKey.otpMessage],
      resetToken: json['resetToken'],
    );
  }
}
