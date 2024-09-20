import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class VerifyOtpRepo {
  static Future<bool> verifyOtp(String otp, String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    API api = API(authToken: '');
    final result = await api.postRequest(
      url: Endpoints.mobileLogin,
      body: {
        "phone": "+91$phoneNumber",
        "otp": otp,
        "deviceType": "PartnerApp"
      },
      requireAuth: false,
    );
    return result.fold(
      (failure) => false,
      (response) async {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['success'] == false) {
          return false;
        } else {
          await prefs.setString("token", responseBody['token']);
          return true;
        }
      },
    );
  }
}
