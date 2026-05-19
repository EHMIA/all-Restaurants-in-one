class UserModel {
  final bool success;
  final User user;

  UserModel({required this.success, required this.user});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'user': user.toJson()};
  }
}

class User {
  final Address address;
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String? profilePic;
  final String? otp;
  final DateTime? otpExpire;
  final int reviewsCount;
  final int favoritesCount;
  final bool isRestaurantOwner;

  User({
    required this.address,
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.profilePic,
    required this.otp,
    required this.otpExpire,
    required this.reviewsCount,
    required this.favoritesCount,
    required this.isRestaurantOwner,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address(details: ''),
      id: json['_id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'] ?? 0,
      // هنا التعديل: سحب الـ url من داخل الـ object
      profilePic: json['profile_pic'] != null
          ? json['profile_pic']['url']
          : null,
      otp: json['otp']?.toString() ?? '',
      otpExpire: json['otpExpire'] != null
          ? DateTime.parse(json['otpExpire'])
          : null,
      reviewsCount: json['reviewsCount'] ?? 0,
      favoritesCount: json['favoritesCount'] ?? 0,
      isRestaurantOwner: json['isRestaurantOwner'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      '_id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'profile_pic': profilePic,
      'otp': otp,
      'otpExpire': otpExpire,
      'reviewsCount': reviewsCount,
      'favoritesCount': favoritesCount,
      'isRestaurantOwner': isRestaurantOwner,
    };
  }
}

class Address {
  final String details;

  Address({required this.details});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(details: json['details'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'details': details};
  }
}
