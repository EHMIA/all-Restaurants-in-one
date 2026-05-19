class EditProfileModel {
  final String message;
  final EditedUser user;

  EditProfileModel({required this.message, required this.user});

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      message: json['message'] ?? '',
      user: EditedUser.fromJson(json['user']),
    );
  }
}

class EditedUser {
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String? profilePic;
  final String role;
  final EditedAddress address;

  EditedUser({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    this.profilePic,
    required this.role,
    required this.address,
  });

  factory EditedUser.fromJson(Map<String, dynamic> json) {
    return EditedUser(
      id: json['_id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profilePic: json['profile_pic'] is Map
          ? json['profile_pic']['url']
          : json['profile_pic'],
      role: json['role'] ?? '',
      address: EditedAddress.fromJson(json['address'] ?? {}),
    );
  }
}

class EditedAddress {
  final String governorate;
  final String city;
  final String street;
  final String details;

  EditedAddress({
    required this.governorate,
    required this.city,
    required this.street,
    required this.details,
  });

  factory EditedAddress.fromJson(Map<String, dynamic> json) {
    return EditedAddress(
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      details: json['details'] ?? '',
    );
  }
}
