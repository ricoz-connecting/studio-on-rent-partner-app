import 'dart:developer';

import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/feature/profile/models/profile.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class EditProfileRepo {
  static Future<bool> editProfile(Profile profile, API api) async {
    final response = await api.patchRequest(
        url: Endpoints.editProfile, body: profile.toJson());
    return response.fold((err) {
      log(err.message.toString());
      return false;
    }, (response) {
      return true;
    });
  }
}
