class APIConstant {
  static const String baseUrl = 'https://chatbox-0dk5.onrender.com';
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String vericationEndpoint = '/auth/send-forget-password-code';
  static const String confirmOtpEndpoint = '/auth/verify-forget-password-code';
  static const String userProfileEndpoint = '/user/profile';
  static String resetPasswordEndpoint = "/auth/reset-password";
  static String updateProfile = "/user/profile";
  static String updateProfilePhoto = "/user/profile-pic";
  static String fetchFriendsEndpoint = "/user/friends";
  static String searchUserEndpoint = "/user/search";
  static String addFriendEndpoint = "/user/send-friend-request";
  static String removeFriendEndpoint = "/user/remove-friend";
}
