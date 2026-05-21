abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String? profilePicUrl;

  EditProfileLoaded({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    this.profilePicUrl,
  });
}

class EditProfileSuccess extends EditProfileState {
  final String message;
  EditProfileSuccess({required this.message});
}

class EditProfileError extends EditProfileState {
  final String error;
  EditProfileError({required this.error});
}

class ProfilePictureUpdated extends EditProfileState {
  final String imagePath;
  ProfilePictureUpdated({required this.imagePath});
}

class NotificationsToggled extends EditProfileState {
  final bool isEnabled;
  NotificationsToggled({required this.isEnabled});
}

class PasswordChangeInitiated extends EditProfileState {}

class DeleteProfilePictureLoading extends EditProfileState {}

class DeleteProfilePictureSuccess extends EditProfileState {
  final String message;
  DeleteProfilePictureSuccess({required this.message});
}

class DeleteProfilePictureError extends EditProfileState {
  final String error;
  DeleteProfilePictureError({required this.error});
}

class ChangePasswordLoading extends EditProfileState {}

class ChangePasswordSuccess extends EditProfileState {
  final String message;
  ChangePasswordSuccess({required this.message});
}

class ChangePasswordError extends EditProfileState {
  final String error;
  ChangePasswordError({required this.error});
}
