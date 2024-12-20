import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class StatusRepo {
  final API _api;
  final Ref _ref;

  StatusRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> getStatus() async {
    final response = await _api.getRequest(url: Endpoints.getKYC);
    return response;
  }
}

final statusRepoProvider = Provider<StatusRepo>((ref) {
  final api = ref.watch(apiProvider);
  return StatusRepo(api: api, ref: ref);
});
