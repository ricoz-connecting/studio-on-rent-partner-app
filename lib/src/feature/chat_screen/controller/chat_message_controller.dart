import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/chat_screen/models/message_model.dart';
import 'package:studio_partner_app/src/feature/chat_screen/repo/chat_message_repo.dart';

class MessageController extends StateNotifier<List<Message>> {
  final MessageRepo _repo;

  MessageController(this._repo) : super([]);

  Future<void> getMessage(
      {required String senderDocId, required String receiverDocId}) async {
    try {
      final result = await _repo.getMessage(
          senderDocId: senderDocId, receiverDocId: receiverDocId);
      result.fold(
        (failure) {
          log('Failure: $failure');
        },
        (response) {
          final data = jsonDecode(response.body);
          final messageList = data['data'] as List;
          final messages =
              messageList.map((message) => Message.fromJson(message)).toList();
          state = messages;
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');
    }
  }

  void addMessage(
      {required String senderDocId,
      required String receiverDocId,
      required String msg}) {
    final message = Message(
      senderDocId: senderDocId,
      receiverDocId: receiverDocId,
      message: msg,
      createdAt: DateTime.now(),
    );
    state = [...state, message];
  }
}

// Provider for controller
final messageControllerProvider =
    StateNotifierProvider<MessageController, List<Message>>((ref) {
  final repository = ref.watch(messageRepoProvider);
  return MessageController(repository);
});
