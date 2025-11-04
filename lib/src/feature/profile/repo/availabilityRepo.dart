import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/models/partnerAvailability.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class AvailabilityRepo {
  final API _api;
  final Ref _ref;
  AvailabilityRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> updateAvailability({
    required Availability availability,
    required String partnerDocId,
  }) async {
    log(jsonEncode(availability.toJson()), name: "Availability JSON");

    final response = await _api.putRequest(
        url: "${Endpoints.updateAvailability}/$partnerDocId",
        body: availability.toJson());
    return response;
  }

  FutureEither<Response> getAvailability({required String partnerDocId}) async {
    final response = await _api.getRequest(
        url: "${Endpoints.getAvailability}/$partnerDocId");
    return response;
  }
}

final availabilityRepoProvider = Provider<AvailabilityRepo>((ref) {
  final api = ref.watch(apiProvider);
  return AvailabilityRepo(api: api, ref: ref);
});
