import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import 'package:studio_partner_app/src/res/strings.dart';

final bookingsRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return BookingsRepo(api: api, ref: ref);
});

class BookingsRepo {
  final API _api;
  final Ref _ref;
  BookingsRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  Future<Response?> getBookings() async {
    final result =
        await _api.getRequest(url: Endpoints.getBookings, requireAuth: true);
    return result.fold((Failure failure) {
      log(failure.message, name: LogLabel.httpGet);
      return null;
    }, (Response response) => response);
  }
}
