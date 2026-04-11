import 'package:resturant_project/core/api/end_points.dart';

class OtpModel {
  final String message;
  OtpModel({required this.message});
  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      message: json[ApiKey.otpMessage],
    );
  }
}