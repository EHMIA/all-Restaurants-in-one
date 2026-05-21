import 'package:resturant_project/core/api/end_points.dart';

class LoginModel {
  final String token;
  final String message;
  final User user;

  LoginModel({required this.token, required this.message, required this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json[ApiKey.token]??'',
      message: json[ApiKey.loginMessage]??'',
      user: User.fromJson(json[ApiKey.loginUser]??{}),
    );
  }
}

class User {
  String? id;
  String? fullname;
  String? email;
  String? phone;
  String? role;

  User({this.id, this.fullname, this.email, this.phone, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json[ApiKey.loginId];
    fullname = json[ApiKey.loginFullname];
    email = json[ApiKey.loginEmail];
    phone = json[ApiKey.loginPhone];
    role = json[ApiKey.loginRole];
  }
}
