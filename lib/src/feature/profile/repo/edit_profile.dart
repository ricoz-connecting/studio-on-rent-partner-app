import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/feature/profile/models/profile.dart';
import 'package:studio_partner_app/src/res/base.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

import '../../file/repository/file_repo.dart';

class ProfileRepo {
  final API _api;
  final Ref _ref;
  ProfileRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> updateProfile(
      {required Profile profile, File? file}) async {
    final body = {
      if (profile.name != null) "name": profile.name,
      if (profile.address != null) "address": profile.address,
      if (profile.city != null) "city": profile.city,
      if (profile.pincode != null) "pincode": profile.pincode,
      if (profile.state != null) "state": profile.state,
      if (profile.country != null) "country": profile.country,
      if (profile.businessName != null) "businessName": profile.businessName,
    };
    if (file != null) {
      final info = await _ref
          .read(fileRepoProvider)
          .uploadFile(file: file, type: UploadFileType.AVATAR);
      if (info != null) {
        body['avatar'] = "${BasePaths.storageURL}${info.key}";
      }
    }
    final response =
        await _api.patchRequest(url: Endpoints.editProfile, body: body);
    return response;
  }
}

final profileRepoProvider = Provider<ProfileRepo>((ref) {
  final api = ref.watch(apiProvider);
  return ProfileRepo(api: api, ref: ref);
});
