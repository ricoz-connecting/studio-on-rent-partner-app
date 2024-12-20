import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

import '../../../res/strings.dart';

final reviewRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return ReviewRepo(api: api);
});

class ReviewRepo {
  final API _api;
  ReviewRepo({required API api}) : _api = api;

  Future<Response?> getReview() async {
    final result =
        await _api.getRequest(url: Endpoints.getReviews, requireAuth: true);
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

  Future<Response?> getStudioReviews({required String studioDocId}) async {
    final result = await _api.getRequest(
      url: "${Endpoints.getStudioReviews}$studioDocId",
      requireAuth: true,
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
}
