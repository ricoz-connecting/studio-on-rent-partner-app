import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/chat/repository/chat_repository.dart';
import 'package:studio_partner_app/src/models/chat_model.dart';

final chatControllerProvider =
    StateNotifierProvider<ChatController, List<ChatModel>>((ref) {
  final repo = ref.watch(chatRepoProvider);
  return ChatController(repo: repo);
});

class ChatController extends StateNotifier<List<ChatModel>> {
  final ChatRepository _repo;

  ChatController({required ChatRepository repo})
      : _repo = repo,
        super([]);

  /// Fetch chat messages for a room
  Future<void> getChatMessages(String roomId) async {
    try {
      final messages = await _repo.fetchMessages(roomId);
      log(messages.toString());
      state = messages;
    } catch (e) {
      print("Error fetching chat messages: $e");
      throw Exception('Failed to fetch messages');
    }
  }

  void addMessage(Map<String, dynamic> messageData) {
    final newMessage = ChatModel.fromJson(messageData);
    state = [...state, newMessage]; // Updating state with a new message
  }

  void updateChatList(ChatModel newMessage) {
    state = [
      ...state,
      newMessage
    ]; // This ensures state updates and UI rebuilds
  }

  /// Send a new message
  Future<void> sendMessage(
      String roomId, String senderId, String message) async {
    try {
      final newMessage = ChatModel(
        roomId: roomId,
        senderId: senderId,
        text: message,
        isRead: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      state = [...state, newMessage];
    } catch (e) {
      print("Error sending message: $e");
      throw Exception('Failed to send message');
    }
  }

  void receiveMessage(Map<String, dynamic> data) {
    final newMessage = ChatModel.fromJson(data);
    state = [...state, newMessage];
    log("📩 New message received: ${newMessage.text}");
  }

  void markMessagesAsRead(Map<String, dynamic> data) {
    final senderId = data['senderId'];

    state = state.map((message) {
      if (message.senderId == senderId && !message.isRead!) {
        return message.copyWith(isRead: true);
      }
      return message;
    }).toList();

    log("✅ Messages from $senderId marked as read");
  }
}
