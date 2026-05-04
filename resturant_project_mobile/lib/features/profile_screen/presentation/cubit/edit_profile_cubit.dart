
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/features/profile_screen/data/repository/edit_profile_repo.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo repo;

  EditProfileCubit({required this.repo}) : super(EditProfileInitial());

  String? selectedImagePath;
  bool notificationsEnabled = true;

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    emit(NotificationsToggled(isEnabled: value));
  }

  void setImagePath(String path) {
    selectedImagePath = path;
    emit(ProfilePictureUpdated(imagePath: path));
  }

  Future<void> saveChanges({
    required String fullname,
    required String email,
    required String phone,
    required String address,
  }) async {
    try {
      emit(EditProfileLoading());

      final result = await repo.editProfile(
        fullname: fullname,
        email: email,
        phone: phone,
        addressDetails: address,
      );

      // Save to local storage
      await StorageHelper.saveUserData(
        name: fullname,
        email: email,
        phone: phone,
        address: address,
      );

      // Emit success with updated fields
      emit(EditProfileSuccess(message: result.message));
      emit(ProfileFieldsUpdated(
        fullName: fullname,
        email: email,
        phoneNumber: phone,
        address: address,
      ));
    } on ServerException catch (e) {
      emit(EditProfileError(error: e.errorModel.error));
    } catch (e) {
      emit(EditProfileError(error: 'Something went wrong'));
    }
  }

  Future<void> changePassword() async {
    emit(PasswordChangeInitiated());
  }
}
