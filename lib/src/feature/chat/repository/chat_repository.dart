import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:studio_partner_app/src/models/chat_model.dart';
import 'package:studio_partner_app/src/res/base.dart';

final chatRepoProvider = Provider<ChatRepository>((ref) {
  return ChatRepository();
});

class ChatRepository {
  static const String baseUrl = BasePaths.baseUrl;

  /// Get or Create a Chat Room
  Future<String?> getOrCreateChatRoom(String userId, String partnerId) async {
    final url = Uri.parse('$baseUrl/chat');

    try {
      log("getOrCreateChatRoom called");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId, "partnerId": partnerId}),
      );
      log(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['_id'];
      }
    } catch (e) {
      print("Error in getOrCreateChatRoom: $e");
    }
    return null;
  }

  /// Fetch messages from a chat room
  Future<List<ChatModel>> fetchMessages(String roomId) async {
    final url = Uri.parse('$baseUrl/chat/$roomId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true && jsonResponse['data'] is List) {
          final List<dynamic> jsonList = jsonResponse['data'];
          return jsonList.map((json) => ChatModel.fromJson(json)).toList();
        }
      }
    } catch (e) {
      print("Error fetching messages: $e");
    }
    return [];
  }
}
