import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/features/auth/login/data/models/otp_model.dart';

class OtpRepo {
  final ApiConsumer api;

  OtpRepo({required this.api});

  Future verifyOtp(String otp, String token) async {
    final response = await api.post(
      EndPoints.otpCode,
      data: {ApiKey.otp: otp},
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    return OtpModel.fromJson(response);
  }
}
