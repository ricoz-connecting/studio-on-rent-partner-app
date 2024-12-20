import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/res/base.dart';
import '../../../core/core.dart';
import '../../../res/endpoints.dart';
import '../../../res/strings.dart';
import '../../file/repository/studio_file_repo.dart';

final studioListRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return StudioListRepo(api: api, ref: ref);
});

class StudioListRepo {
  final API _api;
  final Ref _ref;
  StudioListRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;
  Future<Response?> getstudioList({required String type}) async {
    final result = await _api.getRequest(
      url: Endpoints.getStudio,
      requireAuth: true,
      // queryParams: {
      //   'rentOrSell': type,
      // },
    );
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> updateStudioStatus(
      {required String id, required bool isActive}) async {
    log('studio id : $id isActive : $isActive', name: LogLabel.auth);
    final result = await _api.patchRequest(
      url: "${Endpoints.updateStudio}$id",
      requireAuth: true,
      body: {'isActive': isActive},
    );
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> updateStudio(
      {required String id,
      required Map<String, dynamic> body,
      File? thumbnail,
      List<String>? imageUrl,
      List<File>? images}) async {
    log("images : $images", name: LogLabel.httpPatch);
    if (thumbnail != null) {
      final thumbnailinfo = await _ref
          .read(studioFileRepoProvider)
          .uploadFile(file: thumbnail, type: UploadFileType.THUMBNAIL);
      if (thumbnailinfo != null) {
        body['thumbnail'] = "${BasePaths.storageURL}${thumbnailinfo.key}";
      }
      // Upload the images
    }
    if (images!.isNotEmpty) {
      List<String> imageUrls = [];
      if (imageUrl != null) {
        imageUrls = imageUrl;
      }
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
    log('studio id : $id body : $body', name: LogLabel.httpPatch);
    final result = await _api.patchRequest(
      url: "${Endpoints.updateStudio}$id",
      requireAuth: true,
      body: body,
    );
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.httpPatch,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  FutureEither<Response?> deleteStudio({required String studioId}) async {
    final result = await _api.deleteRequest(
      url: "${Endpoints.deleteStudio}$studioId",
      requireAuth: true,
    );
    return result;
  }
}
