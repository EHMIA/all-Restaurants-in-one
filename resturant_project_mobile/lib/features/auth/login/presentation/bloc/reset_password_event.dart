sealed class ResetPasswordEvent {}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String newPassword;
  final String confirmPassword;

  ResetPasswordSubmitted({
    required this.newPassword,
    required this.confirmPassword,
  });
}
