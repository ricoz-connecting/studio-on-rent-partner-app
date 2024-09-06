import 'dart:convert';
import 'dart:developer';
import '../../src/core/api.dart';
import '../../src/res/endpoints.dart';

class GetImageUrl {
  static Future<Map<String, dynamic>> getUploadUrl() async {
    API api = API(authToken: '');
    final response = await api.postRequest(
        url: Endpoints.fetchUploadImageUrl,
        body: {"type": "avatar", "extension": "png"},
        requireAuth: false);
    return response.fold((failure) => {'success': false}, (response) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      log(responseBody.toString());
      return responseBody;
    });
  }
}
