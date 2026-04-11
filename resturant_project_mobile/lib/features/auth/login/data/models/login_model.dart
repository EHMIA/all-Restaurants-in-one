class LoginModel {
  final String token;
  final String message;
  final User user;

  LoginModel({required this.token, required this.message, required this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['Token']??'',
      message: json['message']??'',
      user: User.fromJson(json['user']??{}),
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
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
  }
}
