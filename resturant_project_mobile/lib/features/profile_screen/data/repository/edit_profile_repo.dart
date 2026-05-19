import 'dart:io';

import 'package:dio/dio.dart';
import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import '../model/edit_profile_model.dart';

class EditProfileRepo {
  final ApiConsumer api;

  EditProfileRepo({required this.api});

  Future<EditProfileModel> editProfile({
    required String fullname,
    required String email,
    required String phone,
    required String addressDetails,
    File? imageFile,
  }) async {
    final userId = await StorageHelper.getUserId();

    if (imageFile != null) {
      // بنبعتها Map عادية جداً لأن الـ API Consumer عندك بيحولها لـ FormData
      final Map<String, dynamic> imageData = {
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_$userId.jpg',
        ),
      };

      await api.patch(
        EndPoints.profileImage,
        data: imageData, // ابعت الماب هنا
        isFormData: true, // والـ Consumer هيحولها لـ FormData.fromMap(data)
      );
    }

    final response = await api.patch(
      EndPoints.editUserProfile(userId ?? ''),
      data: {
        'fullname': fullname,
        'email': email,
        'phone': phone,
        'address': {
          'governorate': '',
          'city': '',
          'street': '',
          'details': addressDetails,
        },
      },
      isFormData: false,
    );

    final model = EditProfileModel.fromJson(response);

    await StorageHelper.saveUserData(
      name: model.user.fullname,
      email: model.user.email,
      phone: model.user.phone,
      address: model.user.address.details,
      profilePic: model.user.profilePic ?? '',
    );

    if (imageFile != null) {
      await StorageHelper.saveProfileImagePath(imageFile.path);
    }

    return model;
  }

  Future<String> deleteProfilePicture(String userId) async {
    final response = await api.delete(EndPoints.deleteProfilePhoto(userId));

    // Clear the profile picture from storage
    await StorageHelper.saveProfileImagePath('');
    await StorageHelper.saveUserData(
      name: '',
      email: '',
      phone: '',
      address: '',
      profilePic: '',
    );

    return response['message'] ?? 'Profile picture deleted successfully';
  }

  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await api.patch(
      EndPoints.changePassword,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
      isFormData: false,
    );

    return response['message'] ?? 'Password changed successfully';
  }
}
