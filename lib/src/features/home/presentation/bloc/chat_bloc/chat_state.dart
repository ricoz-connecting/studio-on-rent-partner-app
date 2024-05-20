part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatFailureState extends ChatState {
  final String message;

  ChatFailureState({required this.message});
}

class ChatSuccessState extends ChatState {
  final List<ChatEntity> chats;

  ChatSuccessState({required this.chats});
}
