import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/base.dart';

class MessageRepo {
  final API _api;
  final Ref _ref;

  MessageRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> getMessage(
      {required String senderDocId, required String receiverDocId}) async {
    final result = await _api.getRequest(
      url:
          "${BasePaths.baseSocketUrl}/messages?senderDocId=$senderDocId&receiverDocId=$receiverDocId",
    );
    return result;
  }
}

final messageRepoProvider = Provider<MessageRepo>((ref) {
  final api = ref.watch(apiProvider);
  return MessageRepo(api: api, ref: ref);
});
