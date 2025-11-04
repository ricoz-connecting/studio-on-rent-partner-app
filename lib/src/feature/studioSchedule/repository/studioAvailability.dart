import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/feature/studioSchedule/models/studioAvailabiltyModel.dart';
import 'package:studio_partner_app/src/models/partnerAvailability.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class StudioAvailabilityRepo {
  final API _api;
  final Ref _ref;
  StudioAvailabilityRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> updateAvailability({
    required StudioAvailability availability,
    required String studioDocId,
  }) async {
    log(jsonEncode(availability.toJson()), name: "Availability JSON");

    final response = await _api.putRequest(
        url: "${Endpoints.studioUpdateAvailability}/$studioDocId",
        body: availability.toJson());
    return response;
  }

  FutureEither<Response> getAvailability({required String studioDocId}) async {
    final response = await _api.getRequest(
        url: "${Endpoints.studioGetAvailability}/$studioDocId");

    return response;
  }
}

final studioAvailabilityRepoProvider = Provider<StudioAvailabilityRepo>((ref) {
  final api = ref.watch(apiProvider);
  return StudioAvailabilityRepo(api: api, ref: ref);
});
