import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../../../core/core.dart';
import '../../../res/endpoints.dart';
import '../../../res/strings.dart';

final studioListRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return StudioListRepo(api: api);
});

class StudioListRepo {
  final API _api;
  StudioListRepo({required API api}) : _api = api;
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

  Future<Response?> updateStudio(
      {required String id, required bool isActive}) async {
    log('studio id : $id isActive : $isActive', name: LogLabel.auth);
    final result = await _api.patchRequest(
      url: "${Endpoints.updateStudio}/$id",
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

  FutureEither<Response?> deleteStudio({required String studioId}) async {
    final result = await _api.deleteRequest(
      url: "${Endpoints.deleteStudio}$studioId",
      requireAuth: true,
    );
    return result;
  }
}
