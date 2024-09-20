import 'package:studio_partner_app/src/res/base.dart';

class Endpoints {
  static const String baseUrl = BasePaths.baseUrl;
  static const String sendOtp = "${baseUrl}partner/sendOTP";
  static const String mobileLogin = "${baseUrl}partner/loginPhone";
  static const String signupEmail = "${baseUrl}partner/signup";
  static const String loginEmail = "${baseUrl}partner/loginEmail";
  static const String changePassword = "${baseUrl}partner/change-password";
  static const String forgotPassword = "${baseUrl}partner/forgot-password";
  static const String resetPassword = "${baseUrl}partner/reset-password";
  static const String resetPasswordSms = "${baseUrl}partner/reset-password-sms";
  static const String getProfile = "${baseUrl}partner/profile";
  static const String editProfile = "${baseUrl}partner/profile";
  static const String logout = "${baseUrl}partner/logout";
  static const String changeEmailPhone = "${baseUrl}partner/change-phone-email";
}
