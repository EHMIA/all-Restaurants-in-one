abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class DeleteAccountLoading extends SettingsState {}

class DeleteAccountSuccess extends SettingsState {
  final String message;
  DeleteAccountSuccess({required this.message});
}

class DeleteAccountError extends SettingsState {
  final String error;
  DeleteAccountError({required this.error});
}
