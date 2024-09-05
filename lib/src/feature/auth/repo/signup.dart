import 'dart:convert';
import 'package:studio_partner_app/src/res/endpoints.dart';
import '../../../core/api.dart';

class SignupRepo {
  static Future<bool> signup(String email, String password) async {
    API api = API(authToken: '');
    final result = await api.postRequest(
      url: Endpoints.signupEmail,
      body: {
        "email": email,
        "password": password,
        "phone": "+919999999999",
      },
      requireAuth: false,
    );
    return result.fold(
      (failure) => false,
      (response) {
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