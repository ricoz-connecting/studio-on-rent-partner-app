import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import '../../src/core/api.dart';
import '../../src/feature/profile/models/profile.dart';

class GetProfileRepo {
  static Future<Profile> getProfile(
      String authToken, BuildContext context, WidgetRef ref) async {
    final api = ref.watch(apiProvider);
    final response = await api.getRequest(url: Endpoints.getProfile);
    return response.fold((failure) => Profile(), (response) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['success'] == false) {
        return Profile();
      } else {
        Profile profile = Profile.fromJson(responseBody['data']);
        return profile;
      }
    });
  }
}
