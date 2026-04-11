class SignUpModel {
  final String token;
  final User user;

  SignUpModel({required this.token, required this.user});
  
  factory SignUpModel.fromJson(Map<String,dynamic> json){
    return SignUpModel(token: json['Token'], user: json['user']);
  }
}

class User {
  final String fullname;
  final String email;
  final String phone;
  final String profilePic;
  final String role;
  final String id;
  final List<String> address;
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
      profilePic: json['profile_pic'],
      role: json['role'],
      id: json['_id'],
      address: json['address'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
