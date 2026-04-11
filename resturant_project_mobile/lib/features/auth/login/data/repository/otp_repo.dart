import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/features/auth/login/data/models/otp_model.dart';

class OtpRepo {
  final ApiConsumer api;

  OtpRepo({required this.api});

  Future verifyOtp(String email, String otp) async {
    final response = await api.post(
      EndPoints.resetPassword,
      data: {ApiKey.email: email, ApiKey.otp: otp},
    );
    return OtpModel.fromJson(response);
  }
}
