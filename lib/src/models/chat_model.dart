// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  final String? id;
  final String? roomId;
  final String? senderId;
  final String? text;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ChatModel({
    this.id,
    this.roomId,
    this.senderId,
    this.text,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  ChatModel copyWith({
    String? id,
    String? roomId,
    String? senderId,
    String? text,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ChatModel(
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        senderId: senderId ?? this.senderId,
        text: text ?? this.text,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["_id"],
        roomId: json["roomId"],
        senderId: json["senderId"],
        text: json["text"],
        isRead: json["isRead"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "roomId": roomId,
        "senderId": senderId,
        "text": text,
        "isRead": isRead,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
