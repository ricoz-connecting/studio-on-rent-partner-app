import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

final earningsHistoryRepoProvider = Provider<EarningsHistoryRepo>((ref) {
  final api = ref.watch(apiProvider);
  return EarningsHistoryRepo(api: api, ref: ref);
});

class EarningsHistoryRepo {
  final API _api;
  final Ref _ref;
  EarningsHistoryRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;
  FutureEither<Response?> getEarningHistory() async {
    final response =
        await _api.getRequest(url: Endpoints.earningHistory, requireAuth: true);
    return response;
  }
}
