import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/features/profile_screen/data/repository/edit_profile_repo.dart';
import '../../data/repository/profile_repo.dart';
import 'edit_profile_state.dart';
import 'profile_cubit.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo repo;
  final UserRepo userRepo;
  final ImagePicker _picker = ImagePicker();

  EditProfileCubit({required this.repo, required this.userRepo})
    : super(EditProfileInitial());

  File? selectedImageFile;
  String? networkProfilePic;
  bool notificationsEnabled = true;

  Future<void> loadUserData() async {
    try {
      emit(EditProfileLoading());
      final userModel = await userRepo.getUserProfile();
      final user = userModel.user;

      networkProfilePic = user.profilePic;

      emit(
        EditProfileLoaded(
          fullName: user.fullname,
          email: user.email,
          phone: user.phone,
          address: user.address.details,
          profilePicUrl: user.profilePic,
        ),
      );
    } on ServerException catch (_) {
      final data = await StorageHelper.getUserData();
      emit(
        EditProfileLoaded(
          fullName: data['name'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          address: data['address'] ?? '',
        ),
      );
    } catch (_) {
      final data = await StorageHelper.getUserData();
      emit(
        EditProfileLoaded(
          fullName: data['name'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          address: data['address'] ?? '',
        ),
      );
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      selectedImageFile = File(picked.path);
      emit(ProfilePictureUpdated(imagePath: picked.path));
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (picked != null) {
      selectedImageFile = File(picked.path);
      emit(ProfilePictureUpdated(imagePath: picked.path));
    }
  }

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    emit(NotificationsToggled(isEnabled: value));
  }

  Future<void> saveChanges({
    required String fullname,
    required String email,
    required String phone,
    required String address,
    required ProfileCubit profileCubit,
  }) async {
    try {
      emit(EditProfileLoading());

      final result = await repo.editProfile(
        fullname: fullname,
        email: email,
        phone: phone,
        addressDetails: address,
        imageFile: selectedImageFile,
      );
      await profileCubit.getProfile();
      emit(EditProfileSuccess(message: result.message));
    } on ServerException catch (e) {
      emit(EditProfileError(error: e.errorModel.error));
    } catch (e) {
      emit(EditProfileError(error: 'Something went wrong'));
    }
  }

  Future<void> deleteProfilePicture(
    {
    required ProfileCubit profileCubit,
  }
  ) async {
    try {
      emit(DeleteProfilePictureLoading());
      final userId = await StorageHelper.getUserId();
      final message = await repo.deleteProfilePicture(userId ?? '');

      selectedImageFile = null;
      networkProfilePic = null;

       await profileCubit.getProfile();
      emit(DeleteProfilePictureSuccess(message: message));
    } on ServerException catch (e) {
      emit(DeleteProfilePictureError(error: e.errorModel.error));
    } catch (e) {
      emit(DeleteProfilePictureError(error: 'Something went wrong'));
    }
  }
}
