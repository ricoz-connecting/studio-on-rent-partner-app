part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetChatEvent extends ChatEvent {
  final String agentId;

  GetChatEvent({required this.agentId});
}
