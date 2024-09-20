import 'dart:convert';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class SignInPhoneRepo {
  static Future<bool> signIn(String phoneNumber) async {
    // final prefs = await SharedPreferences.getInstance();
    API api = API(authToken: '');
    final result = await api.postRequest(
      url: Endpoints.sendOtp,
      body: {
        "otpType": "forLogin",
        "phone": "+91$phoneNumber",
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
          // await prefs.setString("token", responseBody['token']);
          return true;
        }
      },
    );
  }
}
