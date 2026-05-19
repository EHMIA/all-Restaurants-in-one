class UploadProfilePhotoModel {
  final String message;
  final ProfilePicData profilePic;

  UploadProfilePhotoModel({required this.message, required this.profilePic});

  factory UploadProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return UploadProfilePhotoModel(
      message: json['message'] ?? '',
      profilePic: ProfilePicData.fromJson(json['profile_pic'] ?? {}),
    );
  }
}

class ProfilePicData {
  final String url;
  final String publicId;
  final String id;

  ProfilePicData({required this.url, required this.publicId, required this.id});

  factory ProfilePicData.fromJson(Map<String, dynamic> json) {
    return ProfilePicData(
      url: json['url'] ?? '',
      publicId: json['publicId'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
