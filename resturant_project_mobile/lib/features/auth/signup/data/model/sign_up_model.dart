import 'package:resturant_project/core/app_assets/app_assets.dart';

class SignUpModel {
  final String token;
  final User user;

  SignUpModel({required this.token, required this.user});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(token: json['Token'], user: User.fromJson(json['user']));
  }
}

class User {
  final String fullname;
  final String email;
  final String phone;
  final String profilePic;
  final String role;
  final String id;
  final Address address;
  final String createdAt;
  final String updatedAt;

  User({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.profilePic,
    required this.role,
    required this.id,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      profilePic: json['profile_pic'] ?? AppAssets.profile,
      role: json['role'],
      id: json['_id'],
      address: Address.fromJson(json['address']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Address {
  final String details;

  Address({required this.details});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(details: json['details'] ?? '');
  }
}
