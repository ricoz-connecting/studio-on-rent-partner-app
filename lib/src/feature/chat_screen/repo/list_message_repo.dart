import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/base.dart';

class ListMessageRepo {
  final API _api;
  final Ref _ref;

  ListMessageRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> listOfMessage() async {
    final result = await _api.getRequest(
      url:
          "${BasePaths.baseSocketUrl}/api/get-chats-for-user?userDocId=678f7024f8389c9944f10fc8",
    );
    return result;
  }
}

final listMessageRepoProvider = Provider<ListMessageRepo>((ref) {
  final api = ref.watch(apiProvider);
  return ListMessageRepo(api: api, ref: ref);
});
