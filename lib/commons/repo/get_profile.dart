import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/profile/views/profile_screen.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import '../../src/core/api.dart';
import '../../src/feature/profile/models/profile.dart';

class GetProfileRepo {
  static Future<bool> getProfile(String authToken, BuildContext context) async {
    API api = API(authToken: authToken);
    final response = await api.getRequest(url: Endpoints.getProfile);
    return response.fold((failure) => false, (response) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['success'] == false) {
        return false;
      } else {
        Profile profile = Profile.fromJson(responseBody['data']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              profile: profile,
            ),
          ),
        );
        return true;
      }
    });
  }
}
