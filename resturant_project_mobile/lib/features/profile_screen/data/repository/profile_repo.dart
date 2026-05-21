import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';

import '../../../../core/utils/storage_helper.dart';
import '../model/user_model.dart';

class UserRepo {
  final ApiConsumer api;

  UserRepo({required this.api});

  Future<UserModel> getUserProfile() async {
    final userId = await StorageHelper.getUserId();
    print(
      "Fetching profile for UserID: '$userId'",
    );

    if (userId == null || userId.isEmpty) {
      throw Exception("User ID is missing from storage");
    }
    final response = await api.get(EndPoints.userProfile(userId));
    final profileModel=UserModel.fromJson(response);

    await StorageHelper.saveUserId(profileModel.user.id);

    await StorageHelper.saveUserData(
      name: profileModel.user.fullname,
      email: profileModel.user.email,
      phone: profileModel.user.phone,
      address: profileModel.user.address.details,
      createdAt: profileModel.user.createdAt
          .toIso8601String(), 
      profilePic: profileModel.user.profilePic ?? '',
    );
    return  profileModel;
    
  }
}
