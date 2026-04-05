abstract class OtpEvent {
  const OtpEvent();
}

class OtpVerifyButtonPressed extends OtpEvent {
  final String otp;
  final String email;

  const OtpVerifyButtonPressed({required this.otp, required this.email});
}

class OtpResendButtonPressed extends OtpEvent {
  final String email;

  const OtpResendButtonPressed({required this.email});
}
