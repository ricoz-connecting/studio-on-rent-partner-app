import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

final earningsRepoProvider = Provider<EarningsRepo>((ref) {
  final api = ref.watch(apiProvider);
  return EarningsRepo(api: api, ref: ref);
});

class EarningsRepo {
  final API _api;
  final Ref _ref;
  EarningsRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;
  FutureEither<Response?> getEarnings() async {
    final response =
        await _api.getRequest(url: Endpoints.getEarnings, requireAuth: true);
    return response;
  }
}
