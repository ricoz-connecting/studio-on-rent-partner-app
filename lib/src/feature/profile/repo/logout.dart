import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class LogoutRepo {
  static Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    API api = API(authToken: prefs.getString('token') ?? '');
    final result = await api.postRequest(
      url: Endpoints.logout,
    );
    return result.fold(
      (failure) => false,
      (response) async {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['success'] == false) {
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
