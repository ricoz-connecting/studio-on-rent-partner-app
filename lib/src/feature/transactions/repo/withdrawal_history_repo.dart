import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

final withdrawalHistoryRepoProvider = Provider<WithdrawalHistoryRepo>((ref) {
  final api = ref.watch(apiProvider);
  return WithdrawalHistoryRepo(api: api, ref: ref);
});

class WithdrawalHistoryRepo {
  final API _api;
  final Ref _ref;
  WithdrawalHistoryRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;
  FutureEither<Response?> getWithdrawalHistory() async {
    final response = await _api.getRequest(
        url: Endpoints.withdrawalHistory, requireAuth: true);
    return response;
  }
}
