abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

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

class ProfileFieldsUpdated extends EditProfileState {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;

  ProfileFieldsUpdated({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });
}

class NotificationsToggled extends EditProfileState {
  final bool isEnabled;
  NotificationsToggled({required this.isEnabled});
}

class PasswordChangeInitiated extends EditProfileState {}
