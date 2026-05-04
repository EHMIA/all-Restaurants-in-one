import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/features/auth/login/data/models/reset_password_model.dart';

class ResetPasswordRepo {
  final ApiConsumer api;

  ResetPasswordRepo({required this.api});

  Future<ResetPasswordModel> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    final response = await api.patch(
      EndPoints.resetPassword,
      data: {
        ApiKey.password: newPassword,
        ApiKey.confirmPassword: confirmPassword,
      },
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    return ResetPasswordModel.fromJson(response);
  }
}
