class EndPoints {
  //!endPoints
  static const String baseUrl = "https://all-restaurants-in-one.vercel.app/";
  static const String login = "auth/login";
  static const String signUp = "auth/register";
  static const String forgetPassword = "auth/forgot-password";
  static const String otpCode = "auth/verify-otp";
  static const String resetPassword = "auth/reset-password";
  static const String getAllRestuarant = "restaurants";
  static const String favorites = "favorites";
  static const String addRreviews = "/reviews/add-review";
  static const String getRreviews = "reviews/my-reviews";
  static const String deleteRreviews = "reviews/delete-review";
  static String editUserProfile(String userId) =>
      '/user/editUserProfile/$userId';
  static String userProfile(String userId) => 'user/getUserProfile/$userId';
  static String deleteProfilePhoto(String userId) =>
      'user/deleteProfilePhoto/$userId';
  static const String changePassword = 'user/changePassword';
  static const String profileImage = "user/uploadProfilePhoto";
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
  static const String resetToken = 'resetToken';

  //! reset password
  static const String newPassword = 'newPassword';

  //==========================================
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZThkNjRlZGJjNjZjZGJkNTllMDAwYiIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2ODgzNTUzLCJleHAiOjE3NzY4ODcxNTN9.e50dlp3TFSInNHn_SOiIJT0mOv4KXJnR3B2VJK0K9uI";
}
