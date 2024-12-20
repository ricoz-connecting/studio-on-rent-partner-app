import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/feature/file/repository/file_repo.dart';
import 'package:studio_partner_app/src/res/base.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class KycRepo {
  final API _api;
  final Ref _ref;

  KycRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> uploadKyc({
    required String type,
    required String name,
    required String number,
    required File frontImage,
    required File backImage,
  }) async {
    final body = {
      "documentType": type,
      "documentNumber": number,
      "nameOnDocument": name,
    };

    if (frontImage.existsSync()) {
      final frontinfo = await _ref
          .read(fileRepoProvider)
          .uploadFile(file: frontImage, type: UploadFileType.FRONT);
      if (frontinfo != null) {
        body['frontImage'] = "${BasePaths.storageURL}${frontinfo.key}";
      }
    }
    // final frontinfo = await _ref
    //     .read(fileRepoProvider)
    //     .uploadFile(file: frontImage, type: UploadFileType.FRONT);
    // if (frontinfo != null) {
    //   body['frontImage'] = "${BasePaths.storageURL}${frontinfo.key}";
    // }
    if (frontImage.existsSync()) {
      final backinfo = await _ref
          .read(fileRepoProvider)
          .uploadFile(file: backImage, type: UploadFileType.BACK);
      if (backinfo != null) {
        body['backImage'] = "${BasePaths.storageURL}${backinfo.key}";
        log(body.toString());
      }
    }
    // final backinfo = await _ref
    //     .read(fileRepoProvider)
    //     .uploadFile(file: backImage, type: UploadFileType.BACK);
    // if (backinfo != null) {
    //   body['backImage'] = "${BasePaths.storageURL}${backinfo.key}";
    // }
    // log(body.toString());
    final response =
        await _api.postRequest(url: Endpoints.uploadKYC, body: body);
    return response;
  }
}

final kycRepoProvider = Provider<KycRepo>((ref) {
  final api = ref.watch(apiProvider);
  return KycRepo(api: api, ref: ref);
});
