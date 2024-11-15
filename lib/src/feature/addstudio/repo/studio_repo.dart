import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/feature/file/repository/studio_file_repo.dart';
import 'package:studio_partner_app/src/res/base.dart';

import '../../../res/endpoints.dart';

class StudioRepo {
  final API _api;
  final Ref _ref;
  StudioRepo({required API api, required Ref ref})
      : _api = api,
       _ref = ref;
  FutureEither<Response?> createStudio(
      {required Map<String, dynamic> body,
      required File thumbnail,
      required List<File?> images}) async {
    log(body.toString());
    if (thumbnail != null) {
      final thumbnailinfo = await _ref
          .read(studioFileRepoProvider)
          .uploadFile(file: thumbnail, type: UploadFileType.THUMBNAIL);
      if (thumbnailinfo != null) {
        body['thumbnail'] = "${BasePaths.storageURL}${thumbnailinfo.key}";
      }

      // Upload the images
      if (images.isNotEmpty) {
        List<String> imageUrls = [];
        for (File? image in images) {
          if (image != null) {
            final imageInfo = await _ref
                .read(studioFileRepoProvider)
                .uploadFile(file: image, type: UploadFileType.IMAGE);

            if (imageInfo != null) {
              imageUrls.add("${BasePaths.storageURL}${imageInfo.key}");
            }
          }
        }

        body['images'] = imageUrls;
      }
    }
    log(body.toString());
    final response = await _api.postRequest(
        url: Endpoints.createStudio, body: body, requireAuth: true);
    return response;
  }
}

final studioRepoProvider = Provider<StudioRepo>((ref) {
  final api = ref.watch(apiProvider);
  return StudioRepo(api: api, ref: ref);
});
