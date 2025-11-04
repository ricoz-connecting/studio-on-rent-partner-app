import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/base.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class ChatUserRepo {
  final API _api;
  final Ref _ref;

  ChatUserRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> updateProfile({
    required String phone,
    required String email,
    required String userType,
    required String name,
    required String avatar,
  }) async {
    final body = {
      "projectName": "Bookmystudio",
      "phone": phone,
      "email": email,
      "userType": userType,
      "name": name,
      "avatar": avatar,
    };

    final response = await _api.postRequest(
        url: "${BasePaths.baseSocketUrl}/api/create-connection", body: body);
    log(response.toString());
    return response;
  }
}

final chatUserRepoProvider = Provider<ChatUserRepo>(
  (ref) => ChatUserRepo(api: ref.watch(apiProvider), ref: ref),
);
