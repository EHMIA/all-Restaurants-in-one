class EndPoints {
  static const String baseUrl = "https://all-restaurants-in-one.vercel.app/";
  static const String login = "auth/login";
  static const String signUp = "auth/register";
  static const String forgetPassword = "auth/forgot-password";
  static const String resetPassword = "auth/reset-password";
}

class ApiKey {
  static const String errorMessage = "error";
  //! auth keys
  static const String email = "email";
  static const String password = "password";
  static const String fullname = "fullname";
  static const String confirmPassword = "confirmPassword";
  static const String phone = "phone";

  //! forget password
  static const String forgetMessage = 'message';
  static const String otp = 'otp';
  static const String userId = 'userId';

  //! otp
  static const String otpMessage = 'message';
}
