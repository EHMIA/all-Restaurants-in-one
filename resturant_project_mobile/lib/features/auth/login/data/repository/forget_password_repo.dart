import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/features/auth/login/data/models/forget_password_model.dart';

class ForgetPasswordRepo {
  final ApiConsumer api;

  ForgetPasswordRepo({required this.api});

  Future sendOtpByEmail(String email)async{
    final response =await api.post(EndPoints.forgetPassword,data: {
      ApiKey.email:email
    });
    return ForgetPasswordModel.fromJson(response);
  }
  
}