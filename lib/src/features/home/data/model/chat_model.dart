// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({required super.name, required super.photoUrl, required super.time, required super.id, required super.userId, required super.agentId});
 
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] as String,
      photoUrl: Uint8List.fromList(map['photoUrl']['data']),
      time: DateTime.parse(map['time'].toString()),
      id: map['id'] as String,
      userId: map['userId'] as String,
      agentId: map['agentId'] as String,
    );
  }

}
