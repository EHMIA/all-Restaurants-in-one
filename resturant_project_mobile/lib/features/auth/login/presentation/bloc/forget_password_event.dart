sealed class ForgotPasswordEvent {}

class SendOtpEvent extends ForgotPasswordEvent {
  final String emailOrPhone;

  SendOtpEvent({required this.emailOrPhone});
}
