import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/features/auth/login/data/models/login_model.dart';

class LoginRepository {
  final ApiConsumer api;

  LoginRepository({required this.api});

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await api.post(
      EndPoints.login,
      data: {ApiKey.email: email, ApiKey.password: password},
    );
    final loginModel = LoginModel.fromJson(response);


      await StorageHelper.saveToken(loginModel.token);

    return loginModel;
  }
}
