
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
  }) async {
    final userId = await StorageHelper.getUserId();

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
    );

    final model = EditProfileModel.fromJson(response);

    await StorageHelper.saveUserData(
      name: model.user.fullname,
      email: model.user.email,
      phone: model.user.phone,
      address: model.user.address.details,
    );

    return model;
  }
}
