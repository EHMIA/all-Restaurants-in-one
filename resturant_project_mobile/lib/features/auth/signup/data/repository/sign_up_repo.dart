import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/features/auth/signup/data/model/sign_up_model.dart';

class SignUpRepo {
  final ApiConsumer api;

  SignUpRepo({required this.api});

  Future<SignUpModel> signUp({
    required String email,
    required String fullname,
    required String password,
    required String comfirmPassword,
    required String phone,
  })async {
    final response = await api.post(
      EndPoints.signUp,
      data: {
        ApiKey.email: email,
        ApiKey.fullname: fullname,
        ApiKey.password: password,
        ApiKey.confirmPassword: comfirmPassword,
        ApiKey.phone: phone,
      },
    );
    return SignUpModel.fromJson(response);
  }
}
