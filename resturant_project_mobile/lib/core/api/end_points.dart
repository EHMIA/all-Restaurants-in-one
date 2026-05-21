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
  static String deleteAccount(String userId) => 'user/deleteAccount/$userId';
  static const String changePassword = 'user/changePassword';
  static const String profileImage = "user/uploadProfilePhoto";
}

class ApiKey {

  //! multi used keys
  static const String message='message';

  //! error key
  static const String errorMessage = "error";
  //! login keys
  static const String token='Token';
  static const String loginMessage=message;
  static const String loginUser='user';
  static const String loginId='id';
  static const String loginEmail = "email";
  static const String loginPassword = "password";
  static const String loginFullname = "fullname";
  static const String confirmPassword = "confirmPassword";
  static const String loginPhone = "phone";
  static const String loginRole='role';

  //! forget password
  static const String forgetMessage = message;
  static const String otp = 'otp';
  static const String userId = 'userId';
  static const String verificationToken='verificationToken';

  //! otp
  static const String otpMessage = 'message';
  static const String resetToken = 'resetToken';

  //! reset password
  static const String newPassword = 'newPassword';

}
