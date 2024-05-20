import 'package:studio_partner_app/src/features/chat/domain/entity/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required super.id,
      required super.isMe,
      required super.agentID,
      required super.uuid,
      required super.message,
      required super.timestamp});

      
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      isMe: map['isMe'] as bool,
      agentID: map['agentID'] as String,
      uuid: map['uuid'] as String,
      message: map['message'] as String,
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
