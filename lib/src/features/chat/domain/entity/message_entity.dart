// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageEntity {
    String id;
  bool isMe;
  String agentID;
  String uuid;
  String message;
  DateTime timestamp;
  MessageEntity({
    required this.id,
    required this.isMe,
    required this.agentID,
    required this.uuid,
    required this.message,
    required this.timestamp,
  });

  MessageEntity copyWith({
    String? id,
    bool? isMe,
    String? agentID,
    String? uuid,
    String? message,
    DateTime? timestamp,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      isMe: isMe ?? this.isMe,
      agentID: agentID ?? this.agentID,
      uuid: uuid ?? this.uuid,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isMe': isMe,
      'agentID': agentID,
      'uuid': uuid,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory MessageEntity.fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      id: map['id'] as String,
      isMe: map['isMe'] as bool,
      agentID: map['agentID'] as String,
      uuid: map['uuid'] as String,
      message: map['message'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageEntity.fromJson(String source) => MessageEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageEntity(id: $id, isMe: $isMe, agentID: $agentID, uuid: $uuid, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant MessageEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.isMe == isMe &&
      other.agentID == agentID &&
      other.uuid == uuid &&
      other.message == message &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      isMe.hashCode ^
      agentID.hashCode ^
      uuid.hashCode ^
      message.hashCode ^
      timestamp.hashCode;
  }
}
